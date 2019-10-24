Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B51CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3552621929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571957523;
	bh=Tr+D5v69b1GWyAu+ihc/exGnVMlr4mjNUaiaxwuMvS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FIX6osaUJOaWagxpx0sAC7BSbVpd5HokRL65EBbNbkHGCodU5rawd0H5aFJNiPNdA
	 va0xE3bzShnfrVGBGizJusjc/dOwh3bDu9/A3rVay9qYPH62ePbOsamprsC4oAuj6F
	 tSCDdQb6lHYxZ/Ezi2pEWztzAUknMxyCMCCgZheU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfJXWwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45469 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfJXWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:51:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so441493oti.12;
        Thu, 24 Oct 2019 15:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XhqQ+WWf6HSAQiCFWOlHz3vp9dIpy6b0JQie0cmsMSk=;
        b=m/yHaq/kfZyOmzKpF8cOG7ll/2vcHAmQagGG1b+kEG4VNnKRlrxlX0dJ+nz5AI4Pmj
         lnqZpSM0GkJEYyok32wj0tUbAxWm/LU8GcdGir3BUAHTbOihDcV127HkEtvK6u1TaNYp
         rnKUCnEHCQD/QnBbhdb4T1JPQJbIbjIuoO8csTYkA6XPlrxpKm8u67LL9vDdLCDnac1w
         ER5FFSDPgN4w1ss9w+Dik8+OYX4pkLDik5/iFQHkVCH5XQ1P3B9tLroyrHp3izzRzX6b
         3k3SKUFgNAQ29bkODwqBeOxm4XuPINtqG2Na7GCjeAkEQ5DOubXzDSRCgFX7qigpKp09
         PI3A==
X-Gm-Message-State: APjAAAXjjT5jqfdBQu/EB4fUD6bZggVzDRsTxyIuVA2dfPuBAEAOyEfe
        mwAreJRIlgVR4FaovfQIMA==
X-Google-Smtp-Source: APXvYqyqeRgofo9S+QkfRdk2u+QenaBl+3W4BcTyvRR6srGyqxxxcDeZu63U9yFDrtq2KMYIJGTREw==
X-Received: by 2002:a9d:17e9:: with SMTP id j96mr235854otj.217.1571957516505;
        Thu, 24 Oct 2019 15:51:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d81sm40621oig.16.2019.10.24.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:51:55 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:51:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, jjhiblot@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: leds: document the "power-supply"
 property
Message-ID: <20191024225155.GA14792@bogus>
References: <20191021174751.4421-1-jjhiblot@ti.com>
 <20191021174751.4421-2-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021174751.4421-2-jjhiblot@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 19:47:50 +0200, Jean-Jacques Hiblot wrote:
> Most of the LEDs are powered by a voltage/current regulator. Describing it
> in the device-tree makes it possible for the LED core to enable/disable it
> when needed.
> 
> Cc: devicetree@vger.kernel.org
> To: robh+dt@kernel.org
> To: mark.rutland@arm.com
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
