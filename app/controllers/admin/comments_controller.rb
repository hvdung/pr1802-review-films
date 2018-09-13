class Admin::CommentsController < AdminController
    before_action :find_comment, only: [:edit, :update, :destroy]

    def index
        @comments = Comment.paginate page: params[:page],
            per_page: Settings.admin.comments.per_page
    end

    def show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
        if @comment.update comment_params
            flash[:alert] = t ".comment_updated"
            redirect_to admin_comments_path
        else
            flash[:alert] = t ".comment_updated_error"
            render :edit
        end
    end

    def destroy
        @comment.destroy
        redirect_to admin_comments_path
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def find_comment
        @comment = Comment.find_by id: params[:id]
    end
end
