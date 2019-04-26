Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D92206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556288725;
	bh=YE6ZfedV+L+2pU9dksxtof2mqv8Wf7Zbsdk+yICJ+rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yb7F8zVPxOgQ05fg1RxKmkF0P+dyiRG6WQFGVUYbDwBTxyyGMb1rhRkgD6Bb14gkH
	 sT9HT+fSdtgGRThAuNUbGNtH5tdI5l0X5qIrjjcr3VW6WSjHM1j7IgTo9cexzT3xZm
	 ulhyN/ULUcetCWDJhK+Hiw0sVVnGb20MR4SncPcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDZOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:25:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33579 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDZOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:25:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id l1so1222693oib.0;
        Fri, 26 Apr 2019 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z627A3GoZAzp1oHZpj7hwaczcn72BCTYdxYyBr+/I48=;
        b=WYC/IwToycQc7byvjoMOIbZ61eZqO2r63YzUrScLxD3noQc5zed4XttPFxfKiXLH89
         byPC+8JedbnLgwb+Y5R8gH3HycShiyTFfafrK0osUGPwaSlqSVYBpfgnKK7MIyAA19Y5
         V6rtbV3wFWDrTOE0c8GzwuMceuosrj2rghS4NLyXFHW6sOIOop091bpmWjowvXro/WF3
         7HFQ9sYTCTG7O8TmVWmzaKToi+v/uw7bVWBLmU1Wrex2s9lJX+uYPY+395nadLXBJupw
         5g3oFfe6oVXKexxLsOB+XmntpiuUdLRUzOxjORRR1gp1sH14FojWUPFZ8H1NIQpWSrPj
         oSRw==
X-Gm-Message-State: APjAAAU14LahhQgyvrurtn1G1QJNPxU3FcawST1Riu9E1L4xbfsOdlGy
        D26u2QKFV9QKsWW7i6kP5w==
X-Google-Smtp-Source: APXvYqwEC14nIM4gk3GviAy/GGbNfg8j7afpa2OZjbUtE0Iez2j6+vyLl46N9dZiVTMQaqsFhuBOqw==
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr7513903oig.26.1556288723224;
        Fri, 26 Apr 2019 07:25:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p205sm10228480oia.49.2019.04.26.07.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:25:22 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:25:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190426142522.GA15387@bogus>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412102738.12679-2-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 18:27:35 +0800, Leo Yan wrote:
> CoreSight uses below bindings for replicator:
> 
>   Dynamic replicator, aka. configurable replicator:
>     "arm,coresight-dynamic-replicator", "arm,primecell";
> 
>   Static replicator, aka. non-configurable replicator:
>     "arm,coresight-replicator";
> 
> The compatible string "arm,coresight-replicator" is not an explicit
> naming to express the replicator is 'static'.  To unify the naming
> convention, this patch introduces a new compatible string
> "arm,coresight-static-replicator" for the static replicator; the
> compatible string "arm,coresight-replicator" is kept for backward
> compatibility, but tag it as obsolete and suggest to use the new
> compatible string.
> 
> As result CoreSight replicator have below bindings:
> 
>   Dynamic replicator:
>     "arm,coresight-dynamic-replicator", "arm,primecell";
> 
>   Static replicator:
>     "arm,coresight-static-replicator";
>     "arm,coresight-replicator"; (obsolete)
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
