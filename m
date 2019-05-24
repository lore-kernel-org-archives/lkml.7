Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1628C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B354205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558666942;
	bh=dLowSz66hg2+3Cg2JldMlBCLZPDiSfNmkpIaRGvDtA4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YSXfwxb267FEn7C2IqSESlIfNDo+7z7UFr9yAR8PQMiElyOjZtzOdtM8lTnEyCAyy
	 z+yTXHHFpGIQaBwjLn7pW9RfzCBqV6Rzk9J0X6yzfgbt7ky72QnqhBvbsvlh7imrlT
	 os1yag+I/QtytSSP2hW1zu/vZO6pyNGcAc+N+p3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfEXDCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfEXDCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:02:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99F92177E;
        Fri, 24 May 2019 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558666940;
        bh=dLowSz66hg2+3Cg2JldMlBCLZPDiSfNmkpIaRGvDtA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YY7KTf0+s/PusMSewnPa5dPJYAJcRDvmYdAp38Wmh5PZD6HqaJuA6lxWK0bfpRrNB
         suumRziElo40+/R//CwlL/CwT1SmFfQqitUEwHWrU0sqFkqI46j9G7KxQCeU3bmBql
         edE2vg8ZzyKZxZsKOfQpjmFYmSfKAPzcTcArfiPE=
Subject: Re: [PATCH selftests 0/2] Add checkbashisms meta-testcase
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
 <20190323192746.59739e5e9ea0445791ac14ed@kernel.org>
 <20190523223114.4feb6239@oasis.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <f125dc4c-0099-d2e2-b295-26a4619d1ee5@kernel.org>
Date:   Thu, 23 May 2019 21:02:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523223114.4feb6239@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 8:31 PM, Steven Rostedt wrote:
> 
> Shuah,
> 
> Want to take this or would you want me to?
> 
> -- Steve
> 
> 

I can take them through my tree.

thanks,
-- Shuah

