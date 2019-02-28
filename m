Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF121C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1EF2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551364239;
	bh=OqOLUY5NRYcGAzWQVIuAVxFcfs54A9YA+BuNEAIY6wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iZ5h2w+0ph74n8NLqYFi3fw0f/LENi3Qo917QesJLYxnGnl+exNdCVl3Q1LcZqkyS
	 D18o6x3GCN/DC+TWpd3OU5kyaM4eOa1RNXuf5+Rx4ZxFH1MwMH1i69RjrZgYvZ0N3s
	 Y+t13S5UnIkVjy1fnOZek3ypcSMXMBb4AQsESPfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfB1Oai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:30:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40229 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfB1Oah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:30:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so17804147otk.7;
        Thu, 28 Feb 2019 06:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l62lRA4pKFXOV666XU2xqi+y+f6Djy0zZIX+en8EloQ=;
        b=KYxKKgROfarXda854ewIGe8wZR98IAsc/JH35/FQAS8Ystxetjs9ZN3r4VOueFs75J
         jAYfmx4A2G0ZzCnq7Syq/6T3lHpINSGU3iHK2ay//GHrN7yplvD9IzwjeLm2gpggsK1l
         0US+hQqpRijilRyrdFK8cKPPqDjcoO1Gam+PRtmXGX5tTrrtJwQK31Xc01+yxlTV1b91
         xdVmkK22XNWSE8zarQgs5mz4l91kEOCmMTtc9cFhXgXcc063Y/YSleguYlv0rZMoPik6
         /JXE+iVtSotvZ6i34IxDVW0UrE1WYJrDI9nLX2XP+FH6c9Y48ZrcBIkoW2KJJEf1CKp+
         6Evg==
X-Gm-Message-State: APjAAAWDGEdTjDMC0G3PQZLDajI+uoKTZlPbCYPszpOKuevX0DHjy9mU
        uJ3VXA/mV3HiqcD5re3F3g==
X-Google-Smtp-Source: APXvYqwX0IC6lXs8mbngDFM/jyGzSDVSP8vOtewfF5Vftc5KvVv9nCuWatSO3IR38LuJBYDjdf5v4g==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr6056841oto.125.1551364236692;
        Thu, 28 Feb 2019 06:30:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d129sm1703040oia.38.2019.02.28.06.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:30:36 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:30:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        alexandru.marginean@nxp.com, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Message-ID: <20190228143035.GA15928@bogus>
References: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
 <1551188543-28867-5-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551188543-28867-5-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 15:42:23 +0200, Claudiu Manoil wrote:
> Define connection bindings (external PHY connections and internal links)
> for the ENETC on-chip ethernet controllers.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v3 - added this patch to the set
> v4 - documented strictly the enetc node bindings, changed node type
>      from "pci" to "ethernet" and added compatible string (Rob H.)
> 
>  .../devicetree/bindings/net/fsl-enetc.txt          | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
