Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E451C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9F206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574372161;
	bh=5wK6kZoSCFmbGS1jqU9aaTij7Els7KYt4I6xC5NqwUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RmmkKUEefy7nwFZctNe+rr/p6k05OFeP2h6XnWRx10uwIf4mV+BAyRrw3NvWjTCYq
	 uzENIAxIPSzAh25e1A0PRAZWjAjnB2Frmvu7OTRhKlwQ4ZTt8PTp/quwcZ41q+XFNv
	 ApMyP5xCWZca+tqZ1pP0SLPf0FcazisdaDdcv2/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUVgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:36:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41798 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:36:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id e9so4604500oif.8;
        Thu, 21 Nov 2019 13:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMb39BgE3B1+H65j32pY6w10OTOxCkKB2EjgU6VAvkw=;
        b=mRoNbv4Mq4/6nAiiq8m87E+1ka0MlxrGdgZSMtE927FDaEo+OCRtonx/mC/RvCOvIk
         45pIBRjkQjzBo/zd0lxCfxyfvCoLVXXUpOmKWGcodwfFdnwi/tSnKaoVVr9KKUhLLuIx
         irSZhyQmTfZfBfwE+WpvvqaCKLWTWWtidxDtAJv5sfjqEOPEkGCHWZdQigDQ9Bz+qehK
         //nUSEs6Nf8bn0mg/mFciAU6uPsSJZL1whirCEtJ0xroRDJdiv0E4dJjPCMBDF4uKWo1
         0IvaCYucE4gmK4/cBpfbVOK2xEIPa5wrwriytKMBM31005jk8laYIDaA99/rm11DVUDI
         GqIQ==
X-Gm-Message-State: APjAAAWq5TwcURehT33T6/fNkc3oJwzWhQ36PIrpZ8pjA4iHI8cYVuIC
        wNVcxal+I3dbelZPNX5ggBlQ3ds=
X-Google-Smtp-Source: APXvYqwhlPdMj6vzUcQ7JUSZXeyrQbByzSla/+as65TI+kaarPglDk675XBVqHu3a9zBwnjXBiDtRA==
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr9808800oih.57.1574372159366;
        Thu, 21 Nov 2019 13:35:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm1406082otm.80.2019.11.21.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:35:58 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:35:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
Message-ID: <20191121213558.GA14178@bogus>
References: <1574236796-25016-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574236796-25016-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:59:56AM +0100, Krzysztof Kozlowski wrote:
> With split of power domain controller bindings to power-domain.yaml,
> the consumer part was renamed to power-domain.txt breaking the
> references.  Undo the renaming.
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Changes since v2:
> 1. Simplify pattern in Maintainers as Geert suggested,
> 2. Add Reviewed-by.
> 
> Changes since v1:
> 1. Undo the renaming.
> ---
>  .../devicetree/bindings/power/{power-domain.txt => power_domain.txt}    | 0
>  MAINTAINERS                                                             | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/power/{power-domain.txt => power_domain.txt} (100%)

Applied, thanks.

Rob
