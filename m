Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71642184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rbf7MbCJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MK6gOTny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCTTIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:08:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:08:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 210F961A16; Wed, 20 Mar 2019 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553108926;
        bh=hrUkZzldk1J49ETC4WGP4e7M18vs+9aAPPfeiqCQ740=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rbf7MbCJcD1fAWpEt+PK2dYguLEQM02t5Fd4xmio65p0QXDYcDTyD4NM6P4WFiu/4
         gnIY2WZ+H0hci56g5tTMOU6jyPbrGm4Oa1PHfYyd+nswRHHRYyY9/HqnSCcikEPowq
         ow8Jq3JBM/l1FdMYy4Hv7d1vXwyw1I2kqBMdMEkY=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 128A061570;
        Wed, 20 Mar 2019 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553108916;
        bh=hrUkZzldk1J49ETC4WGP4e7M18vs+9aAPPfeiqCQ740=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MK6gOTnyh0g/eTCPBVpvytrDCtJZI6CuczbFbXwZ0RXoQxxunrmgX7Cn36iHMrbu9
         dmBUAthgiysJqpbPrnYAXU2qykyRn7LZCvB1dL49ngePLmQvu84U+xEpEHgaKgUlZN
         fHijupNcVFw2WlWCPM+GySiiqcznfb5phuFbmsxA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 128A061570
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] KVM: arm: vgic: Make two functions static
To:     Yue Haibing <yuehaibing@huawei.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, andre.przywara@arm.com
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20190320141813.10380-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <de8edaed-a37b-f143-75d8-9db9c45c5543@codeaurora.org>
Date:   Thu, 21 Mar 2019 00:38:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320141813.10380-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:48 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1732:5: warning:
>   symbol 'vgic_its_has_attr_regs' was not declared. Should it be static?
> arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-its.c:1753:5: warning:
>   symbol 'vgic_its_attr_regs_access' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   virt/kvm/arm/vgic/vgic-its.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index ab3f477..a97db69 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -1729,8 +1729,8 @@ static void vgic_its_destroy(struct kvm_device *kvm_dev)
>   	kfree(its);
>   }
>   
> -int vgic_its_has_attr_regs(struct kvm_device *dev,
> -			   struct kvm_device_attr *attr)
> +static int vgic_its_has_attr_regs(struct kvm_device *dev,
> +				  struct kvm_device_attr *attr)
>   {
>   	const struct vgic_register_region *region;
>   	gpa_t offset = attr->attr;
> @@ -1750,9 +1750,9 @@ int vgic_its_has_attr_regs(struct kvm_device *dev,
>   	return 0;
>   }
>   
> -int vgic_its_attr_regs_access(struct kvm_device *dev,
> -			      struct kvm_device_attr *attr,
> -			      u64 *reg, bool is_write)
> +static int vgic_its_attr_regs_access(struct kvm_device *dev,
> +				     struct kvm_device_attr *attr,
> +				     u64 *reg, bool is_write)
>   {
>   	const struct vgic_register_region *region;
>   	struct vgic_its *its;


Acked-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
Mukesh

