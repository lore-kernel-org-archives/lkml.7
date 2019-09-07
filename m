Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E74C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765B62178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391808AbfIGPeY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:34:24 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:13139 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388322AbfIGPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:34:24 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6cjG-000AGh-Kk; Sat, 07 Sep 2019 17:34:22 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6cjG-000K7v-GD; Sat, 07 Sep 2019 17:34:22 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 7 Sep 2019 17:34:21 +0200
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Message-Id: <534DB087-C4DC-49A7-93AA-6C7C437DA794@volery.com>
Cc:     linux-kernel@vger.kernel.org
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Sep 2019, at 16:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 

Alright, thanks!

Some stupid other question:

On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.

How can I avoid that?

Regards,
Sandro V.
