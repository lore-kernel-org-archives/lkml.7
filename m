Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15690C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65622075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CcB1cx9a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CcB1cx9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfC1Jh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:37:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Jhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:37:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E766260850; Thu, 28 Mar 2019 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553765873;
        bh=Hpyq0MGeL3bAx3/4liyavv3KHqs9aoVVAXW0LVF6/wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CcB1cx9auxn7XxRQ7Aj1zfT3xFrwJ0Spd3vnrZgLRVLflywkGiIhsyXmYSv3KSqoR
         yuyUsd6m64224aUi04nfMhAqOBHJuVHnHtvygh2oM9iFGoctBH9YsDlaQuJcE1FLko
         EgOV9hSWbqvkYPi/6x9YUHnKJBrMVPyNg4qQZ964=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 043E260364;
        Thu, 28 Mar 2019 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553765873;
        bh=Hpyq0MGeL3bAx3/4liyavv3KHqs9aoVVAXW0LVF6/wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CcB1cx9auxn7XxRQ7Aj1zfT3xFrwJ0Spd3vnrZgLRVLflywkGiIhsyXmYSv3KSqoR
         yuyUsd6m64224aUi04nfMhAqOBHJuVHnHtvygh2oM9iFGoctBH9YsDlaQuJcE1FLko
         EgOV9hSWbqvkYPi/6x9YUHnKJBrMVPyNg4qQZ964=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Mar 2019 15:07:52 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v5 0/3] UFS on APQ8098/MSM8998
In-Reply-To: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
References: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
Message-ID: <4a01550bb22799aa803be2cd674f3a74@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 17:46, Marc Gonzalez wrote:
> Hello,
> 
> This series adds support for the UFS host controller on
> APQ8098/MSM8998-based boards.
> 
> This should be the final rev ;-)

Tested-by: Sibi Sankar <sibis@codeaurora.org>

> 
> Differences between v4 and v5:
> - Drop patches that have already been accepted or spun off
> 
> Differences between v3 and v4:
> - Rebase on top of -next
> - Pick up Douglas Anderson's UFSHC doc fix
> - Document 8998 UFSHC binding
> - Improve UFS PHY binding doc
> - Put the UFS DT patch at the end of the series
> 
> Difference between v2 and v3:
> - Add qcom,msm8998-qmp-ufs-phy compat string and match it in the PHY 
> driver
> - Drop vdd-hba-fixed-regulator
> - Write the reg addresses with full 32-bit width
> - Set regulator-allow-set-load only on the 3 rails used by UFS.
> - Revert the patch introducing ufshcd_set_vccq_rail_unused
> 
> Difference between v1 and v2:
> - New patch to add 'regulator-allow-set-load' prop to all vreg nodes
> - Rename rpmcc node to 'clock-controller' + Add Review tags
> - Drop UFS pinctrl gymnastics (not required, probably left enabled in
> bootloader)
> - Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
> - Fix sizes of ufsphy register areas based on Jeffrey's feedback
> - Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + 
> reboot
> 
> 
> Marc Gonzalez (3):
>   dt-bindings: ufs: Add msm8998 compatible string
>   arm64: dts: qcom: msm8998: Allow UFSHC driver to set-load
>   arm64: dts: qcom: msm8998: Add UFS nodes
> 
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 +++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         | 65 +++++++++++++++++++
>  3 files changed, 88 insertions(+)

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
