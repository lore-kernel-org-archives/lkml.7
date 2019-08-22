Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF3DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27344233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566472072;
	bh=yzTK0bS+fTQtz08FxFYZwoHZNh3a4lSv/tpMsgpUflI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9aj2yKHTvSRdBR5gteTmRF/SXJtsroKGebcynK+OL/TqEdETuUbQdRU45tMsHoCE
	 IgZt8kBb/H3bB5VYPIXwIF2+8mMpgo1PukqjT7avbiFviZFantPMuYxFSdsVnA7U9x
	 MOJslkZbW6zirpbq5v3C9hOjPgKZHEI4cxx0RwMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbfHVLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfHVLHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:07:50 -0400
Received: from localhost (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2878421726;
        Thu, 22 Aug 2019 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566472070;
        bh=yzTK0bS+fTQtz08FxFYZwoHZNh3a4lSv/tpMsgpUflI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RM0QTu0F9I1bGbF0v+794jVOiZp7mrpCh06MtkW5GfMcmY5A81gRf/dTJlakro08/
         0hC0RA5bpOE1uLerHeS+MIzX/W6MgK4qHNkIMEVcR/t9Ue31fPufZNOnwxDFYVpd7V
         JsVqE7PI00uhU5y43L1pyrMZVsu46MJRWYXVBJgE=
Date:   Thu, 22 Aug 2019 16:36:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, broonie@kernel.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190822110638.GN12733@vkoul-mobl.Dlink>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 11:12, Srinivas Kandagatla wrote:
> 
> 
> On 21/08/2019 22:44, Rob Herring wrote:
> > On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
> > > This patch adds bindings for Soundwire Slave devices that includes how
> > > SoundWire enumeration address and Link ID are used to represented in
> > > SoundWire slave device tree nodes.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
> > >   1 file changed, 51 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> > 
> > Can you convert this to DT schema given it is a common binding.
> > 
> 
> I will give that a go in next version!
> 
> > What does the host controller look like? You need to define the node
> > hierarchy. Bus controller schemas should then include the bus schema.
> > See spi-controller.yaml.
> 
> Host controller is always parent of these devices which is represented in
> the example.
> 
> In my previous patches, i did put this slave bindings in bus.txt, but Vinod
> suggested to move it to slave.txt.
> 
> Are you suggesting to add two yamls here, one for slave and one for bus
> Or just document this in one bus bindings?

That would be fine by me :-)

-- 
~Vinod
