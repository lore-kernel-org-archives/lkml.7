Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB055C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9FD20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfDSTn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:43:26 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:59285 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfDSTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:43:26 -0400
Received: from belgarion ([90.76.58.102])
        by mwinf5d31 with ME
        id 2AjK2000J2CLFkS03AjKBi; Fri, 19 Apr 2019 12:43:23 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 19 Apr 2019 12:43:23 +0200
X-ME-IP: 90.76.58.102
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     <axboe@fb.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] lib: scatterlist: Fix to support no mapped sg
References: <1555581006-153458-1-git-send-email-wangzhou1@hisilicon.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 19 Apr 2019 12:43:19 +0200
In-Reply-To: <1555581006-153458-1-git-send-email-wangzhou1@hisilicon.com>
        (Zhou Wang's message of "Thu, 18 Apr 2019 17:50:06 +0800")
Message-ID: <871s1ymg1k.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhou Wang <wangzhou1@hisilicon.com> writes:

> In function sg_split, the second sg_calculate_split will return -EINVAL
> when in_mapped_nents is 0.
>
> Indeed there is no need to do second sg_calculate_split and sg_split_mapped
> when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry in
> original sgl.
>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
That's right. May I know what is the usecase which led you to this fix ?

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
