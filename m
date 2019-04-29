Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD33C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B324F20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556560104;
	bh=7uEIB2ZsBAHxnHKWhlK5gogZ9GfNL0z6khQg0FJEfEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5/D26tV7WYQCAn+qyhGHSHzu1TZVpFYxJB8MSsv8g8VFXh3LTd+JZCyfvWHHEqyc
	 9Q+OPggyymtYP1MLrM5Yuv1FTXRf3jFLGp0uD/ZqfuqKXJLtmFPHX1iIZiH08YVLcm
	 Cnq1GAM33g1ddY1Nh9eoNTkWRtbPF6dHeIgj2BYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfD2RsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:48:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39078 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2RsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:48:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id o39so9438726ota.6;
        Mon, 29 Apr 2019 10:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZFE5rOYc7aUDrk0hdPVUsnyCLMzSmYtEJdwfTLpnBA=;
        b=YWCeHmIVWTl/QvwU4N8KLYWfQckvznEHYecOBLbmTObdq8p4TOiKvTrZJ23P5RN689
         Si0EFXy+D6oeXcEJSaBtvJutwk/UAfu5AT8+DQxwGVtAUoMf5vhjRplYikEscdRcTQ+V
         MsVlxf/w/svYJepjIAyI/tCDCvCANk8Zf1vviZ+dE58w+DVeTZ6VIFS/TO5u5u6+l1BB
         yOtnJ1BlhYpqQfUL9m6iAOI7Y0S6BJciE6ps7JnrtKrCRZEwwPcvkiTFwuYRW12zX0J6
         pP8e3FDfT9MNrWbp745LCDJCCbw46pB8CjjuhKDigUJOsdaYVmxqEEY2XpFdV1hoaZDo
         ItmA==
X-Gm-Message-State: APjAAAWiH6i5r5aLGzjxlM0NAScZ/mF14+QN7YOT1pV8TBI3ePiTx47B
        jKyDiH/9TxSe3rNsHr8RYQ==
X-Google-Smtp-Source: APXvYqxFcsWvYzC0Egzh1oIYiDnPVKr/WIFOW4gi1acr2+enruy3cklggGK48CwdHxAoIDG0T61mPQ==
X-Received: by 2002:a9d:68c6:: with SMTP id i6mr15444685oto.330.1556560102605;
        Mon, 29 Apr 2019 10:48:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w5sm7766257oib.6.2019.04.29.10.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:48:21 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:48:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com,
        dinguyen@kernel.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 2/6] dt-bindings, firmware: add Intel Stratix10 remote
 system update binding
Message-ID: <20190429174821.GA22717@bogus>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
 <1554835562-25056-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554835562-25056-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:45:58PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 remote system
> update (RSU) driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Alan Tull <atull@kernel.org>
> ---
>  .../bindings/firmware/intel,stratix10-rsu.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
> new file mode 100644
> index 0000000..b6250eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
> @@ -0,0 +1,31 @@
> +Intel Remote System Update Driver for Stratix10 SoC
> +============================================
> +The Intel Remote System Update (RSU) driver exposes interfaces
> +accessed through the Intel Service Layer to user space via sysfs
> +interface. The RSU interfaces report and control some of the optional
> +RSU features on Intel Stratix 10 SoC.
> +
> +The RSU feature provides a way for customers to update the boot
> +configuration of a Intel Stratix 10 SoC device with significantly reduced
> +risk of corrupting the bitstream storage and bricking the system.
> +
> +Required properties:
> +-------------------
> +The rsu node has the following mandatory properties, must be located under
> +the firmware/svc node.
> +
> +- compatible: "intel,stratix10-rsu"
> +
> +Example:
> +-------
> +	firmware {
> +		svc {
> +			compatible = "intel,stratix10-svc";
> +			method = "smc";
> +			memory-region = <&service_reserved>;
> +
> +			rsu: rsu {
> +				compatible = "intel,stratix10-rsu";

There's no DT resources, so why does this need to be in DT. Just make 
the driver for the parent instantiate the driver for this.

Rob
