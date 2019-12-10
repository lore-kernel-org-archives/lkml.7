Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53BFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xq9FVbCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLJT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:59:46 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36478 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:59:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBAJxguI031599;
        Tue, 10 Dec 2019 13:59:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576007982;
        bh=YO2CxBp/cIgI68hjeveKHLJnq0CQ+wgfXTQUOWTfTTU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xq9FVbCprz8hzFMifutiq0DZq/ixNnoHPiQRqB95nlEBqWBd38jUgKHNs+VOrZm7f
         vbClaRkvRACORBRBZ0DOY7EjB82acHEhgAOl5qBP1RlPoXFW5ZZ/PCwyc3/lWvpsW/
         9T1rbtq5PssSx6GRSBqzmoQQB86IUWMaLUKN9mW0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBAJxggj117575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 13:59:42 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 13:59:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 13:59:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAJxfMZ063634;
        Tue, 10 Dec 2019 13:59:41 -0600
Date:   Tue, 10 Dec 2019 13:59:08 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] usb: musb: jz4740: Code cleanup
Message-ID: <20191210195908.GB16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210171110.62141-1-paul@crapouillou.net>
 <20191210171110.62141-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210171110.62141-6-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 06:11:09PM +0100, Paul Cercueil wrote:
> Just some code maintenance; no functional change.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

It seems the patch has a few different types of cleanup, coding style,
indentation, data structure change, variable name change...

Please break the changes into multiple patches, each serves one type of
cleanup.

-Bin.
