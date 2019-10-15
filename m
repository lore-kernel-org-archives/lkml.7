Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CDECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E7420650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571160357;
	bh=CIbnCZnNgKr88mYqm7OpZ1dCq2/2XsNzbZYpnUoxnDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZc5Pc37A8QjO1Rk3gXF9l8Lg1jrmdD++BE1ywm2ztSIoa3wn6uf7HWqWSSTNqbFf
	 FXZwrEzY6aSSSSCvkdxt19xmAkn0Tq4UPZcM89vRR5reGa/ONUrV0KVlhaZn4uMnTx
	 FNjnJCp+SVzM1ughw4pzXqH4ov5oy2RuZw1s2Q2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbfJORZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:25:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43894 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388722AbfJORZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:25:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so17518073oih.10;
        Tue, 15 Oct 2019 10:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuLY0T5XCanlGHWiiteaVAS0AqJDC0pQFFmFd4/UATA=;
        b=LtEsW1HuAp629IJBd5FW9dHUPIb4l5EnwWl+sfRYkdmdM2grT341mwT8OajDN4PY7x
         74/Y8NSxupWgMgoKv5fuKst7tC9zlyDAxGmwqHDmq0RNB3itHcPC+bJI7M3prVQqmUp+
         DPrWHvW9aQ88NRAUzKiMelc7MmQ9Q1KeD3W4v18cNguVYi0+//FG/u08TkOrlemhNLaW
         hahReiOYAm7+dzF774Gm6p8ERkZMhkjoGKXqlk+Ji9H4Rri9xzVlPkWuW4xC2Om610bv
         2XF74BCNDnOP6z998nmTTWyOKNRDlsmFRtlZdfpTPJnH1EoTzC2feGv6qEpIkrqiKxDU
         pfew==
X-Gm-Message-State: APjAAAU2VHyVKywH5zahLcvcgxJ6UykF6j3cnGIfDeu2tV06JLQPbn/X
        i7v8gWGRhdcgokH0zcgnRg==
X-Google-Smtp-Source: APXvYqyh/AJuW5SKmbZ5+aKVbLFBePskQhmFvgqaWcF+4jvMRtRbccQskyol9LKjgN6XrE7Ol69g6A==
X-Received: by 2002:aca:2807:: with SMTP id 7mr30578217oix.99.1571160351713;
        Tue, 15 Oct 2019 10:25:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm6549012oto.2.2019.10.15.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:25:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:25:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Convert sharp,ld-d5116z01b panel
 to DT schema
Message-ID: <20191015172550.GA4197@bogus>
References: <20191010210654.37426-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010210654.37426-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 14:06:54 -0700, Jeffrey Hugo wrote:
> Convert the sharp,ld-d5116z01b panel binding to DT schema.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  .../display/panel/sharp,ld-d5116z01b.txt      | 26 ----------------
>  .../display/panel/sharp,ld-d5116z01b.yaml     | 30 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.yaml
> 

Applied, thanks.

Rob
