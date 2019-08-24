Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9428EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F99922CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566671747;
	bh=9N765O+RItokcg7MqxGOP60qDa/cmTnbhzDUQvZdyAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIRHEKRsiVmGsP5kxvgQeyLnAIQ1sersSYJetSDN1fFNm900hr8CLmQGxeErzo3dt
	 poHIPJdF0PaJ+5j7T43s95orAIOvdQXFWedADZBk/SNV9J7Zf/FU5YLkp8M1cSY4NM
	 xIwLA+dmrRSJpFWkVDSyj5/NWaaSKJnITyr25ioo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfHXSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbfHXSfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:35:46 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C132D21897;
        Sat, 24 Aug 2019 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566671745;
        bh=9N765O+RItokcg7MqxGOP60qDa/cmTnbhzDUQvZdyAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbLj+8HuBm8AbXmjPWUGiu+oEdjQnOjsUb4QRNE5o8uSLCZzNu0ZJooy4SX0u5eof
         jnuwDP3+fXiiFjIEE1aH6LfvxWK4NlloC6216i2cQOGXPYozY27QlPYuLMvPAEvHqu
         GxLrsAN5/h8331yRE5XrPzDHjLq98QLmgpMBNQyc=
Date:   Sat, 24 Aug 2019 20:35:33 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: fsl: dspi: Add fsl,ls1088a-dspi
 compatible string
Message-ID: <20190824183532.GB14936@X250>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801083105.30102-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:31:03PM +0800, Chuanhua Han wrote:
> new compatible string: "fsl,ls1088a-dspi".
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

Applied all, thanks.
