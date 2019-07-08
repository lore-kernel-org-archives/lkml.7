Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6013CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4169020861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfGHH6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHH6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 268CB3092640;
        Mon,  8 Jul 2019 07:58:34 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDBC018ACB;
        Mon,  8 Jul 2019 07:58:31 +0000 (UTC)
Subject: Re: [PATCH 2/8] dt-bindings: document PASID property for IOMMU
 masters
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-3-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <4a90dc21-e727-b2f6-1353-cb08babf0ec2@redhat.com>
Date:   Mon, 8 Jul 2019 09:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190610184714.6786-3-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Jul 2019 07:58:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> On Arm systems, some platform devices behind an SMMU may support the PASID
> feature, which offers multiple address space. Let the firmware tell us
> when a device supports PASID.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
> Previous discussion on this patch last year:
> https://patchwork.ozlabs.org/patch/872275/
> I split PASID and stall definitions, keeping only PASID here.
> ---
>  Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 5a8b4624defc..3c36334e4f94 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
>  disable the IOMMU's device tree node in the first place because it would
>  prevent any driver from properly setting up the translations.
>  
> +Optional properties:
> +--------------------
> +- pasid-num-bits: Some masters support multiple address spaces for DMA, by
> +  tagging DMA transactions with an address space identifier. By default,
> +  this is 0, which means that the device only has one address space.
> +
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  
>  Notes:
>  ======
> 

