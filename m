Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BFC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A71216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfI3Nx5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfI3Nx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:53:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C6520842;
        Mon, 30 Sep 2019 13:53:56 +0000 (UTC)
Date:   Mon, 30 Sep 2019 09:53:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Time stamp value in printk records
Message-ID: <20190930095354.08fa0d80@gandalf.local.home>
In-Reply-To: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
References: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 06:33:42 -0700
Sodagudi Prasad <psodagud@codeaurora.org> wrote:

> Hi All,
> 
>  From Qualcomm side, we would like to check with upstream team about 
> adding Raw time stamp value to printk records. On Qualcomm soc, there 
> are various DSPs subsystems are there - for example audio, video and 
> modem DSPs.
> Adding raw timer value(along with sched_clock()) in the printk record 
> helps in the following use cases –
> 1)	To find out which subsystem  crashed first  -  Whether application 
> processor crashed first or DSP subsystem?
> 2)	If there are any system stability issues on the DSP side, what is the 
> activity on the APPS processor side during that time?
> 
> Initially during the device boot up, printk shed_clock value can be 
> matched with timer raw value used on the dsp subsystem, but after APPS 
> processor suspends several times, we don’t have way to correlate the 
> time stamp  value on the DSP and APPS processor. All timers(both apps 
> processor timer and dsp timers) are derived from globally always on 
> timer on Qualcomm soc, So keeping global timer raw values in printk 
> records and dsp logs help to correlate the activity of all the 
> processors in SoC.
> 
> It would be great if upstream team adds common solution this problem if 
> all soc vendors would get benefit by adding raw timer value to  printk 
> 

Hi Prasad,

If you or someone you know would like to present patches for exactly
what you would like to see, that would go a long way.

-- Steve
