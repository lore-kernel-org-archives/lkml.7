Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4403C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86605233FD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566545386;
	bh=2i/tPHQ6yaUr13qI3p1eM/TFcoLYXNVeOjhKb00S12M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRJ1cjjEIqJ1qZTDB6fwuSGXdNnBm6IvAEA9FBMtybWuOU20ngWCj1+wy6C9qGgj/
	 Gwx+VsEYsxSyBp7ZZc7YoM8pkZe3VJOx7g7NC5drkYc7Om96zDeRhMbgIsAVo2AgEp
	 +rpZfjF/CGpJzLfc/Pdyz1q4BfFsFPew6+PZULx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfHWH3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbfHWH3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:29:45 -0400
Received: from localhost (unknown [106.200.210.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED6D22CEC;
        Fri, 23 Aug 2019 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566545384;
        bh=2i/tPHQ6yaUr13qI3p1eM/TFcoLYXNVeOjhKb00S12M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6ABXy29gh3qSQN8IYqa6XHQZq/QbzUAZ2NE+vaAzfIM+e5k67nhQhtokZbcjxSJ4
         TC+1kdlC50rEiTpR7gqK6SxES7dd//RAR3Byq2kNIOopsTMqV0yZG7Apr/7BGnPFuh
         pjzxPGWwr4Z4E5F/xRkwtYBcYAcHBWE01G6QST1s=
Date:   Fri, 23 Aug 2019 12:58:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
Subject: Re: [PATCH v2 4/5] dt-bindings: soundwire: add bindings for Qcom
 controller
Message-ID: <20190823072831.GE2672@vkoul-mobl>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813083550.5877-5-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 09:35, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.

Rob.. ?

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> new file mode 100644
> index 000000000000..436547f3b155
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> @@ -0,0 +1,167 @@
> +Qualcomm SoundWire Controller Bindings
> +
> +
> +This binding describes the Qualcomm SoundWire Controller along with its
> +board specific bus parameters.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
> +		    Example:
> +			"qcom,soundwire-v1.3.0"
> +			"qcom,soundwire-v1.5.0"
> +			"qcom,soundwire-v1.6.0"
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of SoundWire controller
> +		    address space.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the SoundWire Controller IRQ
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: should be "iface" for SoundWire Controller interface clock
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the SoundWire Controller interface clock
> +
> +- #sound-dai-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 1 for digital audio interfaces on the controller.
> +
> +- qcom,dout-ports:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be count of data out ports
> +
> +- qcom,din-ports:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be count of data in ports
> +
> +- qcom,ports-offset1:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify payload transport window offset1 of each
> +		    data port. Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-offset2:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify payload transport window offset2 of each
> +		    data port. Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-sinterval-low:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should be sample interval low of each data port.
> +		    Out ports followed by In ports. Used for Sample Interval
> +		    calculation.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-word-length:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be size of payload channel sample.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-block-pack-mode:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be 0 or 1 to indicate the block packing mode.
> +		    0 to indicate Blocks are per Channel
> +		    1 to indicate Blocks are per Port.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-block-group-count:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be in range 1 to 4 to indicate how many sample
> +		    intervals are combined into a payload.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-lane-control:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be in range 0 to 7 to identify which	data lane
> +		    the data port uses.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-hstart:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be number identifying lowerst numbered coloum in
> +		    SoundWire Frame, i.e. left edge of the Transport sub-frame
> +		    for each port. Values between 0 and 15 are valid.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-hstop:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be number identifying highest numbered coloum in
> +		    SoundWire Frame, i.e. the right edge of the Transport
> +		    sub-frame for each port. Values between 0 and 15 are valid.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,dports-type:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be one of the following types
> +		    0 for reduced port
> +		    1 for simple ports
> +		    2 for full port
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +Note:
> +	More Information on detail of encoding of these fields can be
> +found in MIPI Alliance SoundWire 1.0 Specifications.
> +
> += SoundWire devices
> +Each subnode of the bus represents SoundWire device attached to it.
> +The properties of these nodes are defined by the individual bindings.
> +
> += EXAMPLE
> +The following example represents a SoundWire controller on DB845c board
> +which has controller integrated inside WCD934x codec on SDM845 SoC.
> +
> +soundwire: soundwire@c85 {
> +	compatible = "qcom,soundwire-v1.3.0";
> +	reg = <0xc85 0x20>;
> +	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
> +	clocks = <&wcc>;
> +	clock-names = "iface";
> +	#sound-dai-cells = <1>;
> +	qcom,dports-type = <0>;
> +	qcom,dout-ports	= <6>;
> +	qcom,din-ports	= <2>;
> +	qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
> +	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
> +	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
> +
> +	/* Left Speaker */
> +	left{
> +		....
> +	};
> +
> +	/* Right Speaker */
> +	right{
> +		....
> +	};
> +};
> -- 
> 2.21.0

-- 
~Vinod
