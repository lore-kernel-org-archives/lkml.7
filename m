Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4042084F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfD0BcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfD0BcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:32:20 -0400
Received: from oasis.local.home (unknown [107.18.234.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799752054F;
        Sat, 27 Apr 2019 01:32:19 +0000 (UTC)
Date:   Fri, 26 Apr 2019 21:32:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] tracing: kdb: The skip_lines parameter should
 have been skip_entries
Message-ID: <20190426213216.7835d14a@oasis.local.home>
In-Reply-To: <CAD=FV=XbHa3GrgVMAAcf2e0W5t1gc--Z2t0vWa9RhSo32w12zA@mail.gmail.com>
References: <20190319171206.97107-1-dianders@chromium.org>
        <CAD=FV=XbHa3GrgVMAAcf2e0W5t1gc--Z2t0vWa9RhSo32w12zA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 15:26:48 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Tue, Mar 19, 2019 at 10:12 AM Douglas Anderson <dianders@chromium.org> wrote:
 
> Steven: do you know if/when you plan to take this series?  There's no
> crazy hurry and if you like I can sent a calendar alert to remember to
> ping you after 5.1 is released so you can land this in a "for 5.3"
> queue.  Just let me know.  :-)

I can add this in this to my queue for this coming merge window.

-- Steve
