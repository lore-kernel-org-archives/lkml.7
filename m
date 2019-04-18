Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B0C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039A12184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfDRHfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:35:46 -0400
Received: from ns.iliad.fr ([212.27.33.1]:50628 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbfDRHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:35:46 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 9A9E120140;
        Thu, 18 Apr 2019 09:35:44 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7E3A8200C9;
        Thu, 18 Apr 2019 09:35:44 +0200 (CEST)
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>
Cc:     Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190418152954.255015e1@canb.auug.org.au>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
Date:   Thu, 18 Apr 2019 09:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418152954.255015e1@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 18 09:35:44 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2019 07:29, Stephen Rothwell wrote:

> Today's linux-next merge of the phy-next tree got a conflict in:
> 
>   Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> between commit:
> 
>   369b89366a3d ("dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy")
> 
> from the qcom tree and commit:
> 
>   2815588ea64b ("dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-pcie-phy")
> 
> from the phy-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hello Stephen,

The current state of Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
is indeed:

		For "qcom,msm8998-qmp-usb3-phy" must contain
			"phy", "common".
		For "qcom,msm8998-qmp-ufs-phy": must contain:
			"ufsphy".
		For "qcom,msm8998-qmp-pcie-phy" must contain:
			"phy", "common".
		For "qcom,sdm845-qmp-usb3-phy" must contain:
			"phy", "common".


It is not clear to me what I could/should have done differently to avoid
the conflict?

Regards.
