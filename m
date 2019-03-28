Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D878C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2A72183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553792432;
	bh=FxjT1mJ7AbDwVZbnBrm7F/Qrqe3hBYeknFPMPDhtT6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Gm6Y8ykvzVKlYmQoeTHW7Rbhl8RtLf941UE/V2jWlJwGMU54cITGOjrMtFathE3U
	 U7ltENDQnDao7y700fj+TbDdVNJltEO7LhmiVFDHPMQ91IQTHK7jBnTidLX0UFyiO/
	 k+3mVr6MIpxH3Cs4AsDgPvrqnltRbP6JMkGfzbNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfC1RAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:00:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35425 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1RAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:00:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so16361788oib.2;
        Thu, 28 Mar 2019 10:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZzcHV/BVkk9ONQG5UPcEceG5zDcJ6gFQBVy9RP3/80=;
        b=mfrs3T+jFgiGjaCaoos9MkRJ03fxYkBtaqYfd0+ES862Vf7+uhZ70ukxdCps4kJ6TG
         DKWo8Ay+YZvg4Lwb81zKmnNs2lVBqtqx09+w4kptDZiVEQEJoge36Wlvn3EcQz8rgTt4
         pExARG5lqx7CemOBpr1AvbeyYsOYgBvVVcombbutMK3Om7Lb0oRAsh2sZPlGd8PsghfZ
         9HszdOLANnDwU6fu6e1DF75WTmJLU2FoCyfjad8uofK8/cLFc7QT8kAFxx2bmRuLpFk1
         TxVFYhZp/DrRixonql251driQ8yXSqicBQMSTJh9ROgl5b42aGEhH1/SiKqGdRqPRwtg
         Z4Ig==
X-Gm-Message-State: APjAAAUa4Nt/arS97UkSybvCfjGZo3KxyR+Zo5E02dUhEGSWZn0U+twp
        XDlEn/7hKEg5mSGlsYCeSw==
X-Google-Smtp-Source: APXvYqyZQE3R2I1kP4cq+xXPK1NCvLJK952UIWS2GjS1JDd4jBd/SnVnauR6KT0bK6F2bhPXaOQ6Pg==
X-Received: by 2002:aca:c141:: with SMTP id r62mr668321oif.160.1553792429392;
        Thu, 28 Mar 2019 10:00:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q19sm10233755ota.28.2019.03.28.10.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:00:28 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:00:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, nava.manne@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Subject: Re: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190328170028.GA10815@bogus>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
 <20190326143129.2608-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326143129.2608-7-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 20:01:29 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v5:
> 		-Moved pcap node as a child to firwmare
> 		 node as suggested by Rob.
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
> 		-Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.
> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
