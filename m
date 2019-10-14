Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78ADECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6321835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571073165;
	bh=HwD6mHtjnnDQLBpdVJDJQmUVa9+46A0MsMrWo2jCPko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tz11CnERuXSM2FoOvynBEaQAcAHhsC1rnm6NCWSfKQR90YSKTSvW8AdElgyxXW1q+
	 Lf2uv/9AKF+BK0995BSVqjFPaLLVEgHCTxjHcAHkZfL30uZV/HjGczKw31iXFnsNKR
	 PGKC89i6zsIMy9nx9opkmMxOVxiq9tG3RSRGgG9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfJNRMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:12:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39172 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388374AbfJNRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:12:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so14421644otr.6;
        Mon, 14 Oct 2019 10:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ZnoujlKTwiwmEY9FI0zWDU67daL9913J5sT0svGqzM=;
        b=OYh4ZSxL0XTBjGiOS5hKd0RWlqDm7+RVgEDJdtotxdgm14Ee22brlFuTghRSrAaz+s
         hi7rO2374aH3NCd+3ETdNo9ZY29DPLrxNf0Xn57kxhZXm98K6P4FPRY1OBvoo4DXDLax
         6lkYV8TtKK8pEsPvH8Law7MQqoI5XN54szW1Bd0dU9JrKd0Sl0U+ucg3ORr85bRIbAA9
         x5yy1aIrviWADND3v4v7S5m7yb4GzFmdIqdF3+aL2D/GDSdymwseN3QgM1VOmHAxIq6l
         +L0OSaBuufOFCWSeIjUewBwasqAwuPJ1ToZx3T2En2pWU97DzP85L+A25Tx+/vhZo0us
         ui/w==
X-Gm-Message-State: APjAAAXL8hj7lwME8x/rrGp/gNrCZf1H3nkcenaVMbyBLowcRrIGzkNa
        WmErDOXRs5K1sBFS6b4SDQ==
X-Google-Smtp-Source: APXvYqyIb1FLv7/3zxJW43drLgoBfkwz/dbgzFnccw5D0lgTY+KQu3bizoMtyKSuptfPur62KU7D7w==
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr19262238otq.54.1571073162881;
        Mon, 14 Oct 2019 10:12:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u141sm5671461oie.40.2019.10.14.10.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:12:41 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:12:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom
 controller
Message-ID: <20191014171241.GA24989@bogus>
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:44:22PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt

Next time, do a DT schema.

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

This needs to be the actual versions supported, not examples. Elsewhere 
in QCom bindings, we've used standard SoC specific compatibles as there 
never tends to be many SoCs with the same version. Anything different 
here?

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

Up to how many?

> +
> +- qcom,din-ports:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be count of data in ports

Up to how many?

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

Is there some sort of addressing that needs to be defined?

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

space       ^
> +		....
> +	};
> +
> +	/* Right Speaker */
> +	right{

ditto

> +		....
> +	};
> +};
> -- 
> 2.21.0
> 
