% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom.R
\name{geos_binary_pred}
\alias{geos_binary_pred}
\alias{st_intersects}
\alias{geos_binary_pred}
\alias{st_disjoint}
\alias{geos_binary_pred}
\alias{st_touches}
\alias{geos_binary_pred}
\alias{st_crosses}
\alias{geos_binary_pred}
\alias{st_within}
\alias{geos_binary_pred}
\alias{st_contains}
\alias{geos_binary_pred}
\alias{st_contains_properly}
\alias{geos_binary_pred}
\alias{st_overlaps}
\alias{geos_binary_pred}
\alias{st_equals}
\alias{geos_binary_pred}
\alias{st_covers}
\alias{geos_binary_pred}
\alias{st_covered_by}
\alias{geos_binary_pred}
\alias{st_equals_exact}
\alias{geos_binary_pred}
\alias{st_is_within_distance}
\title{Geometric binary predicates on pairs of simple feature geometry sets}
\usage{
st_intersects(x, y, sparse = TRUE, prepared = TRUE)

st_disjoint(x, y = x, sparse = TRUE, prepared = TRUE)

st_touches(x, y, sparse = TRUE, prepared = TRUE)

st_crosses(x, y, sparse = TRUE, prepared = TRUE)

st_within(x, y, sparse = TRUE, prepared = TRUE)

st_contains(x, y, sparse = TRUE, prepared = TRUE)

st_contains_properly(x, y, sparse = TRUE, prepared = TRUE)

st_overlaps(x, y, sparse = TRUE, prepared = TRUE)

st_equals(x, y, sparse = TRUE, prepared = FALSE)

st_covers(x, y, sparse = TRUE, prepared = TRUE)

st_covered_by(x, y, sparse = TRUE, prepared = TRUE)

st_equals_exact(x, y, par, sparse = TRUE, prepared = FALSE)

st_is_within_distance(x, y, dist, sparse = TRUE)
}
\arguments{
\item{x}{object of class \code{sf}, \code{sfc} or \code{sfg}}

\item{y}{object of class \code{sf}, \code{sfc} or \code{sfg}}

\item{sparse}{logical; should a sparse index list be returned (TRUE) or a dense logical matrix? See below.}

\item{prepared}{logical; prepare geometry for x, before looping over y?}

\item{par}{numeric; parameter used for "equals_exact" (margin);}

\item{dist}{distance threshold; geometry indexes with distances smaller or equal to this value are returned; numeric value or units value having distance units.}
}
\value{
If \code{sparse=FALSE}, \code{st_predicate} (with \code{predicate} e.g. "intersects") returns a dense logical matrix with element \code{i,j} \code{TRUE} when \code{predicate(x[i], y[j])} (e.g., when geometry i and j intersect); if \code{sparse=TRUE}, an object of class \code{sgbp} with a sparse list representation of the same matrix, with list element \code{i} an integer vector with all indices j for which \code{predicate(x[i],y[j])} is \code{TRUE} (and hence \code{integer(0)} if none of them is \code{TRUE}). From the dense matrix, one can find out if one or more elements intersect by \code{apply(mat, 1, any)}, and from the sparse list by \code{lengths(lst) > 0}, see examples below.
}
\description{
Geometric binary predicates on pairs of simple feature geometry sets
}
\details{
For most predicates, a spatial index is built on argument \code{x}; see \url{http://r-spatial.org/r/2017/06/22/spatial-index.html}.
Specifically, \code{st_intersects}, \code{st_disjoint}, \code{st_touches} \code{st_crosses}, \code{st_within}, \code{st_contains}, \code{st_contains_properly}, \code{st_overlaps}, \code{st_equals}, \code{st_covers} and \code{st_covered_by} all build spatial indexes for more efficient geometry calculations. \code{st_relate}, \code{st_equals_exact}, and \code{st_is_within_distance} do not.

Sparse geometry binary predicate (\code{sgbp}) lists have the following attributes: \code{region.id} with the \code{row.names} of \code{x} (if any, else \code{1:n}), and \code{predicate} with the name of the predicate used.

`st_contains_properly(A,B)` is true if A intersects B's interior, but not its edges or exterior; A contains A, but A does not properly contain A.

See also \link{st_relate} and \url{https://en.wikipedia.org/wiki/DE-9IM} for a more detailed description of the underlying algorithms.

\code{st_equals_exact} returns true for two geometries of the same type and their vertices corresponding by index are equal up to a specified tolerance.
}
\examples{
pts = st_sfc(st_point(c(.5,.5)), st_point(c(1.5, 1.5)), st_point(c(2.5, 2.5)))
pol = st_polygon(list(rbind(c(0,0), c(2,0), c(2,2), c(0,2), c(0,0))))
(lst = st_intersects(pts, pol))
(mat = st_intersects(pts, pol, sparse = FALSE))
# which points fall inside a polygon?
apply(mat, 1, any)
lengths(lst) > 0
# which points fall inside the first polygon?
st_intersects(pol, pts)[[1]]
}
