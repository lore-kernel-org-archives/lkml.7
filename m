Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DEC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BA720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561961708;
	bh=ilZV0SIdnC6KQqrECJ2dASQKpsEhCCtdERzUguOYjcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KMw3ICNh1Kbag+2dNPU95AG9kv/DCD8hGsCtDpsem0o7+AFroE0cOQe3D+XpdzfBN
	 pEvr63qgR18dQJVVGPFg5K/8XmNsNx4Di2M96M+rQnk0DqpyXYVx4aXmkmOjqerk14
	 4Nh2q62KJw0L7Q0bRLZ5BOINidP/khCXt8puct0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfGAGPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfGAGPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:15:05 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C3E208C4;
        Mon,  1 Jul 2019 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561961704;
        bh=ilZV0SIdnC6KQqrECJ2dASQKpsEhCCtdERzUguOYjcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAf+PQ1aK5gG8O9JVySIOpgQEJ8f9g9ZfUmlv6r8WjKTMOjeULrpPNIVfq15xlQ1V
         NOR2z3AxNvyc5pI0OaLi2fNPY6mV2Nq4axdv83Vuh6qDDv2WIC99gjUr++chXDzvwV
         4ne8obQJ3drV7hN9RcgP4oJHZlHUwzrVrkTbSoig=
Date:   Mon, 1 Jul 2019 11:41:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
Subject: Re: [RFC PATCH 1/5] dt-bindings: soundwire: add slave bindings
Message-ID: <20190701061155.GJ2911@vkoul-mobl>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-19, 11:40, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices which includes how
> SoundWire enumeration address is represented in SoundWire slave device
> tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/bus.txt     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/bus.txt b/Documentation/devicetree/bindings/soundwire/bus.txt
> new file mode 100644
> index 000000000000..19a672b0d528
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/bus.txt

The bindings are for slave right and the file is bus.txt?

> @@ -0,0 +1,48 @@
> +SoundWire bus bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire controller bindings are very much specific to vendor.
> +
> +Child nodes(SLAVE devices):
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
> +for a device. Addition to below required properties, child nodes can
> +have device specific bindings.
> +
> +Required property for SoundWire child node if it is present:
> +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
> +		  SoundWire Enumeration address comprising SoundWire
> +		  Version, Manufacturer ID, Part ID and Class ID,
> +		  shall be in lower-case hexadecimal with leading
> +		  zeroes suppressed.
> +		  Version number '0x10' represents SoundWire 1.0
> +		  Version number '0x11' represents SoundWire 1.1
> +		  ex: "sdw10,0217,2010,0"

any reason why we want to code version number and not say sdw,1.0,...
and so on?

> +
> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> +		  Enumeration Address. Instance ID is for the cases
> +		  where multiple Devices of the same type or Class
> +		  are attached to the bus.

instance id is part of the 48bit device id, so wont it make sense to add
that to compatible as well?

> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <1>;
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <2>;
> +		...
> +	};
> +};
> -- 
> 2.21.0

-- 
~Vinod
