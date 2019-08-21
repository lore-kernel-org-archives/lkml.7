Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EFF22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566378623;
	bh=W9CJXEr9ZkiNKd2KgCE+lVmTvH2ChSyocXu1r1dXMXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GI4Z8m68rKj2pZqzn/omyBry33Bg5Emx74iRaAnIkO0lA3s9/FRxYvNYO8V4qv1bI
	 k73V8AIXwbbC00EanBzeHbDE+XLQFKTlz4zhSXHiuKBNmhsUnMQJUkeqRXWgm5QlCp
	 eVYpH5cIFTEZ2u+hW6+F16jzfV674nbSHQk0uKsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHUJKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfHUJKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:10:22 -0400
Received: from localhost (unknown [106.201.100.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9B622CF7;
        Wed, 21 Aug 2019 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566378621;
        bh=W9CJXEr9ZkiNKd2KgCE+lVmTvH2ChSyocXu1r1dXMXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGxA0HKW+pO5EmaAU5VHVO9k08vuiGjEf0lotHaARtvj8B27zro+4/zK1TGcH9V4y
         2wKV+KmxOtiolr/P4cIowle0i+7VrHfuttRd2hvF1R7eyr4vkobK28CzGkzPMm7gob
         RFHJt/LPOe1e3p92Jo7PqbooGHa9h4V/5smLax7E=
Date:   Wed, 21 Aug 2019 14:39:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190821090909.GJ12733@vkoul-mobl.Dlink>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-19, 14:34, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.

Rob does this look good to you, I intent to apply the soundwire parts

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
> new file mode 100644
> index 000000000000..201f65d2fafa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> @@ -0,0 +1,51 @@
> +SoundWire slave device bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire slave devices:
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
> +and Class ID for a device. Addition to below required properties,
> +child nodes can have device specific bindings.
> +
> +Required properties:
> +- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
> +		  Is the textual representation of SoundWire Enumeration
> +		  address along with Link ID. compatible string should contain
> +		  SoundWire Link ID, SoundWire Version ID, Instance ID,
> +		  Manufacturer ID, Part ID and Class ID in order
> +		  represented as above and shall be in lower-case hexadecimal
> +		  with leading zeroes. Vaild sizes of these fields are
> +		  LinkID is 1 nibble,
> +		  Version ID is 1 nibble
> +		  Instance ID in 1 nibble
> +		  MFD in 4 nibbles
> +		  PID in 4 nibbles
> +		  CID is 2 nibbles
> +
> +		  Version number '0x1' represents SoundWire 1.0
> +		  Version number '0x2' represents SoundWire 1.1
> +		  ex: "sdw0110217201000" represents 0 LinkID,
> +		  SoundWire 1.0 version slave with Instance ID 1.
> +		  More Information on detail of encoding of these fields can be
> +		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw0110217201000";
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw0120217201000";
> +		...
> +	};
> +};
> -- 
> 2.21.0

-- 
~Vinod
