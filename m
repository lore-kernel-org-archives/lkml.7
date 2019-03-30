Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14486C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC0C218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfC3MkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbfC3MkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:40:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C95218A3;
        Sat, 30 Mar 2019 12:40:17 +0000 (UTC)
Date:   Sat, 30 Mar 2019 08:40:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190330084016.24f8ad46@gandalf.local.home>
In-Reply-To: <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
        <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
        <20190330110747.GA3461@hari-Inspiron-1545>
        <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 13:01:41 +0100
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> OK, I see. IMO, it would be better to have 2 patches for this:
> one for the redundant assignment to pin6 and anotther one for
> the IS_ENABLED() change but feel free, if needed, to add my

I agree with it being separate patches. I'm big on the "one patch
accomplishes one task" ideology.

-- Steve
