Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2229C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBCA20862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEPDcD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 23:32:03 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:34336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfEPDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:32:03 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 23:32:02 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 1F1728124C98
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 03:24:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4500C182CED28;
        Thu, 16 May 2019 03:24:46 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: bee45_c789c6f4c840
X-Filterd-Recvd-Size: 2640
Received: from [172.30.16.70] (unknown [50.233.106.81])
        (Authenticated sender: rostedt@goodmis.org)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 May 2019 03:24:45 +0000 (UTC)
Date:   Wed, 15 May 2019 20:24:43 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com> <1553106531-3281-2-git-send-email-divya.indi@oracle.com> <20190516090942.75f3a957ceed20201edc91a6@kernel.org> <a96e884d-534f-65ef-8f82-85cd52953695@oracle.com> <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Divya Indi <divya.indi@oracle.com>
CC:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <F331FDC8-9E63-4042-A933-BDC197C9A031@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 15, 2019 8:05:29 PM PDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>> >> diff --git a/kernel/trace/trace_events.c
>b/kernel/trace/trace_events.c
>> >> index 5b3b0c3..81c038e 100644
>> >> --- a/kernel/trace/trace_events.c
>> >> +++ b/kernel/trace/trace_events.c
>> >> @@ -832,6 +832,7 @@ static int ftrace_set_clr_event(struct
>trace_array *tr, char *buf, int set)
>> >>   
>> >>   	return ret;
>> >>   }
>> >> +EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
>> > I found this exports a static function to module. Did it work?
>> 
>> I had tested the changes with my module. This change to static was
>added 
>> in the test patch, but somehow missed it in the final patch that was 
>> sent out.
>
>If you can send some example module patch under samples/, that is more
>helpful for us to check it. And it is possible to use in kselftest too.
>
>> 
>> Will send a new patch along with a few additional ones to add some
>NULL 
>> checks to ensure safe usage by modules and add the APIs to a header
>file 
>> that can be used by the modules.
>
>It seems your's already in Steve's ftrace/core branch, so I think you
>can make
>additional patch to fix it. Steve, is that OK?
>

Yes. In fact I already sent a pull request to Linus.  Please send a patch on top of my ftrace/core branch.


Thanks,

-- Steve

>Thank you,
>
>> 
>> Thanks,
>> 
>> Divya
>> 
>> >
>> > Thank you,
>> >

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
