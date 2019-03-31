Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D04C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DC620882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014574;
	bh=4rbQiAnNyaE96Q0KZglLam+ixXRD5q7FE5n3TVg68H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rAyAiaOW79vJD+Je1jucIokx2+1zjhOPefN1DWJ1Qu3ZX9qKkF1LddJRJoxTRCY8c
	 fAEy+fVSXZ8ZMlfw95neFp59SqHrEjpHDM+QpddicGm7Q+KJGDv9BHFxmwGCWWlbJ8
	 kjUYy5s+H/rsyPv4BFPmxhvdZgL2VDhBpMmizpeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfCaGmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCaGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so3168315pgf.2;
        Sat, 30 Mar 2019 23:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2mPbzGyB9bJBzNPcOIr1laKohf+YIwuR7A1HDeRpuY=;
        b=YV2wzrjtvyBfmgHfTMh0A0nTXlpbYMT7mbCEIaovPdSBu80+VbF5YsM6F5U0MSjTr6
         pw7oPYXSe/Cy2aSxug/UO5maVcarpI+Hlz+1LnfK+3njf/fFe52Bm18tnwsXOC7n/Frp
         xzClkc7PmZ2Iulid3YHPHDNTss3hxrXzHgueyfOZRlwHKO+Ix+nru3NpdkSBpV0QLHYw
         uUwdO/u9Kxr3wI2OhJS2vmLsjKCyDV56JEP1hnZia0NwFUUvJj9eyUOJuPeXwVXpNyCL
         Aw0/oZHvCOqgesngv1XQV1HvmDMiJurFlsPXiPPQe0RJxPvHco9aKzIf7L4c98HqnNet
         0uTQ==
X-Gm-Message-State: APjAAAXsYcmpVrbxwd3b0wIclzIzZU85feMRLL1qcBTGt0gh6EwtoWcT
        cmTSa2PzmLhqbZ8d2uY8eA==
X-Google-Smtp-Source: APXvYqyjingfZlbtvp9hcuEh8V8vdsSHHxbc7enIHOEWYbxLov00sJosu/BAiD0y6uCcXQmQSxYKMA==
X-Received: by 2002:a62:209c:: with SMTP id m28mr16589083pfj.233.1554014570467;
        Sat, 30 Mar 2019 23:42:50 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id f125sm10389849pfc.91.2019.03.30.23.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:49 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:42:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     mark.rutland@arm.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: scsi: ufs-cdns: Update Cadence UFS
 compatibility list
Message-ID: <20190331025745.GA28612@bogus>
References: <20190327144405.5716-1-jank@cadence.com>
 <20190327144405.5716-2-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327144405.5716-2-jank@cadence.com>
X-Mutt-References: <20190327144405.5716-2-jank@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:44:04PM +0000, Jan Kotas wrote:
> This patch adds a new compatible string description for
> CDNS UFS HCD + M31 16nm PHY.

The phy is not a separate block? 

> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  Documentation/devicetree/bindings/ufs/cdns,ufshc.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> index a04a4989e..02347b017 100644
> --- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> @@ -5,8 +5,9 @@ Each UFS controller instance should have its own node.
>  Please see the ufshcd-pltfrm.txt for a list of all available properties.
>  
>  Required properties:
> -- compatible	: Compatible list, contains the following controller:
> -			"cdns,ufshc"
> +- compatible	: Compatible list, contains one of the following controllers:
> +			"cdns,ufshc" - Generic CDNS HCI,
> +			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm PHY
>  		  complemented with the JEDEC version:
>  			"jedec,ufs-2.0"
>  
> -- 
> 2.15.0
> 

