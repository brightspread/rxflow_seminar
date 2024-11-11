import RxFlow

public enum HomeStep: Step {
    case homeIsRequired
    case homeDetailIsRequired
    case homeDetailIsCompleted
    case moreIsCompleted
    case moreIsRequired
    case homeIsCompleted
}
