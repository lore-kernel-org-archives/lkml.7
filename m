Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05C620644
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563942573;
	bh=OveqHMIRxgy8l8c4DZ8hum0ETgBRoNfJPeUqSZ1Fi+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LbK6VOjZmDm20U+SRYPknmwbTIa/8ngTndqL8T4PDT9p41ZYN0+gdGt9F1d0BDluB
	 9GtktiiXF0sws66q2ZuQcAvgzVRpKH316/zolVVAWtX2sG0Vi4C//VxDeluRlsyfNh
	 SeEQyUR1HjgJctnRrkogbG0zty0x5iJP6h49M28c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGXE3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfGXE3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:29:32 -0400
Received: from localhost (unknown [171.76.105.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EC620644;
        Wed, 24 Jul 2019 04:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563942571;
        bh=OveqHMIRxgy8l8c4DZ8hum0ETgBRoNfJPeUqSZ1Fi+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIHxVbhL9n7YZj9KwDL3qZWrr6DwqlTPSe7Zi9lCtt/4LRTmz30FpeAFLpJMm0nU5
         FT6ii6hR7fueEMKInQDdr36MPfhcy1edNbBsrjTvukxQEXVByH5hOSkuguknKjHOXP
         +Mb/OpKndVGqSau0OA34Xeei+aRghng3vszIZM6g=
Date:   Wed, 24 Jul 2019 09:58:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v6 0/5] soc: qcom: Add SoC info driver
Message-ID: <20190724042819.GG12733@vkoul-mobl.Dlink>
References: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-19, 04:05, Vaishali Thakkar wrote:
> This patchset adds SoC info driver which can provide information
> such as Chip ID, Chip family and serial number about Qualcomm SoCs
> to user space via sysfs. Furthermore, it allows userspace to get
> information about custom attributes and various image version
> information via debugfs.
> 
> The patchset cleanly applies on top of v5.2-rc7.

And on v5.3-rc1 :) and I have tested this on db845c, seems to work fine
for me

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
