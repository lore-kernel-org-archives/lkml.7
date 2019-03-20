Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C892184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCTVGz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:06:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47922 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfCTVGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:06:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 58683609187F;
        Wed, 20 Mar 2019 22:06:53 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YGw392y7buh6; Wed, 20 Mar 2019 22:06:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 07CEE60ED8A7;
        Wed, 20 Mar 2019 22:06:53 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CemW--m36dOW; Wed, 20 Mar 2019 22:06:52 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id ACD6D609187F;
        Wed, 20 Mar 2019 22:06:52 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     yang.yang29@zte.com.cn, dwmw2@infradead.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: check dstlen for jffs2_zlib_compress()
Date:   Wed, 20 Mar 2019 22:06:52 +0100
Message-ID: <4416301.M1b3l0cs3q@blindfold>
In-Reply-To: <201903201046335762775@zte.com.cn>
References: <201903201046335762775@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. März 2019, 03:46:33 CET schrieb yang.yang29@zte.com.cn:
> Hi Richard:
> 
> 
> 
>    Is the patch make any progress ?

Well, you ignored my questions.
Can you please check my last mail?

Thanks,
//richard


