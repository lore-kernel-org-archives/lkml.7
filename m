Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457D4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F60D20729
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLQXyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQXyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:54:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADCE621775;
        Tue, 17 Dec 2019 23:54:02 +0000 (UTC)
Date:   Tue, 17 Dec 2019 18:54:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: ftrace trace_raw_pipe format
Message-ID: <20191217185401.30824f2c@gandalf.local.home>
In-Reply-To: <20191217183641.1729b821@gandalf.local.home>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
        <20191217173403.61f4e2d8@gandalf.local.home>
        <20191217183641.1729b821@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 18:36:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Also note, once you are here, you don't need to use the
> tep_print_event() to print out the fields of record. You can also
> extract the data from the event directly. Or you could register a
> handler that will get called via the tep_print_event().

And of course, if you are unaware, trace-cmd does all this for you too:

 http://www.trace-cmd.org

;-)

-- Steve
