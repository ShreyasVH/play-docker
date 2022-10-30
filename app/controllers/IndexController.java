package controllers;

import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Http;

public class IndexController extends Controller
{
	public Result get(String input)
	{
		return ok("GET REQUEST with input: " + input);
	}

	public Result post(Http.Request request)
	{
		return ok("POST REQUEST with payload: " + request.body().asJson().toString());
	}

	public Result put(Http.Request request)
	{
		return ok("PUT REQUEST with payload: " + request.body().asJson().toString());
	}

	public Result delete()
	{
		return ok("DELETE REQUEST");
	}
}