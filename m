Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1F2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbfDRP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRP0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:26:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D240A20821;
        Thu, 18 Apr 2019 15:26:08 +0000 (UTC)
Date:   Thu, 18 Apr 2019 11:26:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ktest: introduce REBOOT_RETURN_CODE to confirm the
 result of REBOOT
Message-ID: <20190418112607.0923e5df@gandalf.local.home>
In-Reply-To: <20190418135943.12640-1-msys.mizuma@gmail.com>
References: <20190418135943.12640-1-msys.mizuma@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 09:59:43 -0400
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Unexpected power cycle occurs while the installation of the
> kernel.
> 
>    ssh root@Test sync ... [0 seconds] SUCCESS
>    ssh root@Test reboot ... [1 second] FAILED!
>    virsh destroy Test; sleep 5; virsh start Test ... [6 seconds] SUCCESS
> 
> That is because REBOOT, the default is "ssh $SSH_USER@$MACHINE
> reboot", exits as 255 even if the reboot is successfully done,
> like as:
> 
>    ]# ssh root@Test reboot
>    Connection to Test closed by remote host.
>    ]# echo $?
>    255
>    ]#
> 
> To avoid the unexpected power cycle, introduce a new parameter,
> REBOOT_RETURN_CODE to judge whether REBOOT is successfully done
> or not.
> 

Thanks for sending the patch. I added it to my local queue, and will
use it for testing of my changes to the Linux kernel, and it will
eventually be merged upstream.

-- Steve

