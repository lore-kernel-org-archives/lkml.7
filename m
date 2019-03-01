Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C844C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231CB20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbfCAO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:58:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388566AbfCAO6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:58:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B837B118;
        Fri,  1 Mar 2019 14:58:08 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     keescook@chromium.org
Cc:     joel@joelfernandes.org, tony.luck@intel.com, ccross@android.com,
        anton@enomsg.org, duwe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: automatically dump and clean dmesg entries
Date:   Fri, 01 Mar 2019 15:58:08 +0100
Message-ID: <3683314.agOEaCLz2O@house>
In-Reply-To: <35267159.Lyx5QdZ5Rb@house>
References: <35267159.Lyx5QdZ5Rb@house>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 1, 2019 3:53:25 PM CET Thomas Renninger wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> Dump a previous oops or panic, which has made it to pstore,
> to the new syslog after reboot, optionally deleting it.
> This can happen automatically, without user land interaction.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> CC: Thomas Renninger <trenn@suse.de>

This is a patch which is (was) part of the SUSE kernel for quite a while.
Iirc someone from Fujitsu requested this.

Anyway, it has not been sent upstream yet, but looks useful.
Please consider to merge this one if you like it.
Otherwise it will probably get dropped to Nirvana as we only keep upstream 
accepted (not SuSE specific) patches.

I adjusted the patch to latest linux-2.6 git HEAD state and gave it a test 
compile.

Thanks,

      Thomas
