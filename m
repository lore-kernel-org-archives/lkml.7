Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB4C80D42
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965424804
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269658;
	bh=BCzvPI61LvHDyIJV5GUuFl49OJH5QK2a3uqnndrK9XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ar3a+WM9wfkf9vvh4+DabvNP+Edhw0ydJbX20PjG24PfUC0mJpcPVSL5EgCVt+auL
	 xAS3FJ6SKr/auwUmOvJ5WpDRpR82jxiIHLNtny9qEaTqz7nIheaStQ9j9s+t2oewqF
	 eSy8jqzAQGagVq6ZtTlT8YWkkv1R3qnmiZHqfOpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfLMTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:10:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42427 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:10:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so299079otd.9;
        Fri, 13 Dec 2019 11:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vImPv04WGeNaWlCnAr6u+MXH0lm+G+inNDjxTwv0uh8=;
        b=CWaUk1SbhCcPn6azYyIWWic6WmMqQ6AS6Yv9CEMIEXSnZYhUUQyzaCm/MB9anx36aj
         uuiN9vZJE4U/ne5X862gMxqOpRAnWfSB4gMfVzf00YgdfFyZeCyDnc80osnOBdmexOFl
         W32vEC8XFeU23M+lq8Hb+tavlm8Vwshg3tuJ5uO+C790hHVpnod3kian9cnHdfnc+PFh
         ZFW9xS53SHPUiHUkUsr0eczBgkWfZksOl/6K6bNlYMiV4pFIFS3/JlU7nLjsGYIP3TTL
         /53vWctEcWRdSn7ksPIpoH6Pc6v1j/Ky+4O/XRkcy2NwO7bj/acfoFmd08rv7zhpzNXI
         pmEQ==
X-Gm-Message-State: APjAAAVyGFkZa63uGFestM6lZDkMiGuXD6qyBc9Wf78wuVL3coI3+vvv
        sx0QdMBJ7jLjtPK1/UfApQ==
X-Google-Smtp-Source: APXvYqxsRQNWKOiW7wZgxEaz7ZXEJ6cCxMTePzGhx295WsoMtFcK/Hrfvkg78SNa+3tZ4dWM9jbeng==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr17205249otp.155.1576264253619;
        Fri, 13 Dec 2019 11:10:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm3581023oii.2.2019.12.13.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:10:51 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:10:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: Add Broadcom STB USB PHY binding
 document
Message-ID: <20191213191051.GC28558@bogus>
References: <20191210132132.41509-1-alcooperx@gmail.com>
 <20191210132132.41509-7-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210132132.41509-7-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 08:21:25 -0500, Al Cooper wrote:
> Add support for bcm7216 and bcm7211
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
