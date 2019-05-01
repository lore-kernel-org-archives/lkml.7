Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702B02085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:15:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40258 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:15:58 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A0197133E97C0;
        Wed,  1 May 2019 14:15:57 -0700 (PDT)
Date:   Wed, 01 May 2019 17:15:56 -0400 (EDT)
Message-Id: <20190501.171556.558136305355226946.davem@davemloft.net>
To:     hofrat@osadl.org
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rds: ib: force endiannes annotation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1556593977-15828-1-git-send-email-hofrat@osadl.org>
References: <1556593977-15828-1-git-send-email-hofrat@osadl.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 May 2019 14:15:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Tue, 30 Apr 2019 05:12:57 +0200

> While the endiannes is being handled correctly as indicated by the comment
> above the offending line - sparse was unhappy with the missing annotation
> as be64_to_cpu() expects a __be64 argument. To mitigate this annotation
> all involved variables are changed to a consistent __le64 and the
>  conversion to uint64_t delayed to the call to rds_cong_map_updated().
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied.
