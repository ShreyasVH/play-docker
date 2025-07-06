package controllers;

import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Http;

import java.util.HashMap;

public class IndexController extends Controller
{
	public Result get(Http.Request request, String input)
	{
		return ok(Json.toJson(new HashMap<String, String>(){{put("input", input);}}));
	}

	public Result post(Http.Request request)
	{
		return ok("POST REQUEST with payload: " + request.body().asJson().toString());
	}

	public Result put(Http.Request request)
	{
		return ok("PUT REQUEST with payload: " + request.body().asJson().toString());
	}

	public Result delete(Http.Request request)
	{
		return ok("DELETE REQUEST");
	}
}