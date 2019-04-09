Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4B9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F1421841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDIAWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:22:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53212 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDIAWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:22:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5DF5127E76;
        Mon,  8 Apr 2019 20:22:14 -0400 (EDT)
Date:   Tue, 9 Apr 2019 10:22:11 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/NCR5380: Avoid compiler warning when -Wimplicit-fallthrough
 is enabled
In-Reply-To: <fd71e91a-92e4-9e96-7d5a-4d9a58f7128f@embeddedor.com>
Message-ID: <alpine.LNX.2.21.1904091018590.25@nippy.intranet>
References: <4e853f171366e040818346def7fb043347670662.1551995342.git.fthain@telegraphics.com.au> <fd71e91a-92e4-9e96-7d5a-4d9a58f7128f@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Gustavo A. R. Silva wrote:

> Hi all,
> 
> Friendly ping:
> 
> Who can take this?
> 
> Thanks
> 

It has been queued up by Martin and James on git.kernel.org. Apparently it 
is to be pushed in the v5.2 merge window.

-- 
