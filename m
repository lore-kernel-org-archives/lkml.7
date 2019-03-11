Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A69C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6A62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552344868;
	bh=wJHxrGU541NfH2Casv1fX813sSdYrTv/v2dNj07H6VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fZ8I040YOzT/Fg7MXzEwKPIhQYMrCPa/wvCq88Z1ARvui7u6dmto0lD9KfmILTxM5
	 GPkfqZtpA+fZrh6jw+jqQVdOSPZ52eXoVWRl5tvz5vMTK7SPy4CLA+g0Q0HvvZ9gqc
	 S9Vil+KpamSh1Q6Vw6Vbo/DBUqnoFIoFi5OCo7SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCKWy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:54:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36790 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfCKWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:54:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id t206so525135oib.3;
        Mon, 11 Mar 2019 15:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQh9vdQEIsq8DvmmnZRLmJ/XuoNIs22AjkjdtNoVnfo=;
        b=URHyc7hMEdx+x4MlEG+ohhRv7L5T0BL60baQnXVFsO2n9eEtsRM+a1WXplXNm/ux8E
         3UudwTn7f6MDNE6qLgigQ6GAw5Gowv6SOx5irwdxtIw8zf8O6uXirqqTHmGIzd9IIzKa
         1A4oWIV16aMlxT/qmw9Xv5uPZVtU6KifzWGhhQrJYXvoatpe0ULKhAXkbYNBRE1X2FQ4
         xx0XKo0rC+tquUHAAAaPNgPTU0OmHmoLhX4JwUwqal+hYkqJdng8qzAB8TMuMsK2dKMT
         b9EBw50ukFXSrxo+GBsDdAphA/WfTK/2d7oJ1LYctRiB4Yio8J6TQZVcIiRBVKy6ejtR
         GiFA==
X-Gm-Message-State: APjAAAWjBzRzRLzRTfT/5uiljed3eQ5Q3+tPRk45r7/Sr+n/ML8FbFwm
        BrCXAi9yF68vIiVrPd3eaQ==
X-Google-Smtp-Source: APXvYqzFMqR1XNHBNluAZxGs0qUUwT4ajCMK4P81GovVkE75s2CVPuVZJmdUmplWyjnWRnghXNp+kQ==
X-Received: by 2002:aca:851:: with SMTP id 78mr18038oii.60.1552344865562;
        Mon, 11 Mar 2019 15:54:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g2sm2804727otq.24.2019.03.11.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:54:25 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:54:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: display: rockchip: add document for
 rk3066 hdmi
Message-ID: <20190311225424.GA8922@bogus>
References: <20190306224113.24853-1-jbx6244@gmail.com>
 <20190306224113.24853-5-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306224113.24853-5-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Mar 2019 23:41:13 +0100, Johan Jonker wrote:
> This patch adds a binding that describes the HDMI controller for
> rk3066.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../display/rockchip/rockchip,rk3066-hdmi.txt      | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
