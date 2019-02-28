Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754B72171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LkqPc7PL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XBCWNkNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfB1FmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:42:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1FmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:42:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E191C60E59; Thu, 28 Feb 2019 05:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551332526;
        bh=dTBq9QRDhroH7e0Eyk6vbbsHSHtFM+f1Y2kU1Zb+4rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LkqPc7PLk8cce3rwwVbVp5BZVW4pM9jagjodnkGyatRQV1fbIciMo9puq1nHhjOuX
         TV/0w8iaqd8Mef4tbadbNmNvQ5DVayedx0XH38ceyhRv9yks4IJfoQQYkU7AhJkvM8
         jX7Fb3qfzmqSkCaEv4TB9JmXs1gG5u7C4SXZY9xk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 43AAC60A05;
        Thu, 28 Feb 2019 05:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551332525;
        bh=dTBq9QRDhroH7e0Eyk6vbbsHSHtFM+f1Y2kU1Zb+4rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XBCWNkNMhIbxTpeu+uTU4QOXwIop7KGYTbY8Vq63vmkRlWUe16rir/qEAdyhVAu04
         /pfDrRtoZWF5a2uuB2Ette0cDS0/9x/6s39T1oZ7KdXvIU5wT9AaRMlUjdpRLcojYH
         zvYYFGpWUkL68RQLbkaXxNvejpshkpCqptyRvIa4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Feb 2019 11:12:05 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v6 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
In-Reply-To: <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
 <20190206051335.23799-9-bjorn.andersson@linaro.org>
 <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
 <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
Message-ID: <af6fdebc06e097d7828b2b82a7bdebc3@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Doug,

On 2019-02-28 02:33, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 26, 2019 at 3:54 PM Doug Anderson <dianders@chromium.org> 
> wrote:
>> 
>> Hi,
>> 
>> On Tue, Feb 5, 2019 at 9:13 PM Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>> >
>> > From: Sibi Sankar <sibis@codeaurora.org>
>> >
>> > This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>> >
>> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> > ---
>> >
>> > Changes since v5:
>> > - None
>> >
>> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
>> >  1 file changed, 58 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > index 560c16616ee6..5c41f6fe3e1b 100644
>> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > @@ -1612,6 +1612,64 @@
>> >                         };
>> >                 };
>> >
>> > +               mss_pil: remoteproc@4080000 {
>> > +                       compatible = "qcom,sdm845-mss-pil";
>> > +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
>> > +                       reg-names = "qdsp6", "rmb";
>> 
>> I found that when I disabled IOMMU bypass by booting with
>> "arm-smmu.disable_bypass=y" that I'd get this failure:
>> 
>> ---
>> 
>> [   13.633776] qcom-q6v5-mss 4080000.remoteproc: MBA booted, loading 
>> mpss
>> [   13.647694] arm-smmu 15000000.iommu: Unexpected global fault, this
>> could be serious
>> [   13.660278] arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0
>> 0x00000000, GFSYNR1 0x00000781, GFSYNR2 0x00000000
>> ...
>> [   14.648830] qcom-q6v5-mss 4080000.remoteproc: MPSS header
>> authentication timed out
>> [   14.657141] qcom-q6v5-mss 4080000.remoteproc: port failed halt
>> [   14.664983] remoteproc remoteproc0: can't start rproc
>> 4080000.remoteproc: -110
>> 
>> ---
>> 
>> Adding "iommus = <&apps_smmu 0x781 0>;" here fixed my problem.  NOTE
>> that I'm no expert on IOMMUs so you should confirm that this is right,
>> but if it is then maybe you could include it in the next spin of the
>> series?  I got the "0x781" just by looking at the value of the GFSYNR1
>> in the above splat.  I wasn't sure what to put for the mask so I put
>> 0x0.
> 
> Upon more testing the "iommus" line that I came up with avoids the
> global fault but doesn't actually work.  I just get:
> 
> qcom-q6v5-mss 4080000.remoteproc: failed to allocate mdt buffer

AFAIK modem does not have a smmu in front of it.

We have reserved memory nodes for mba and mpss,
however for mdt authentication we just rely on
dma_alloc_attrs with DMA_ATTR_FORCE_CONTIGUOUS
for allocation which seems to fail here.

> 
> I'm hoping someone from Qualcomm can help out here and say how this
> should be solved.  Thanks!

Yeah I'll enable arm-smmu.disable_bypass and
have a go at booting modem.

> 
> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
