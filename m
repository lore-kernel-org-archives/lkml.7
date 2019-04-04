Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8598C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC04206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfDDPK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:10:26 -0400
Received: from ns.iliad.fr ([212.27.33.1]:55334 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfDDPK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:10:26 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C8D621FF4E;
        Thu,  4 Apr 2019 17:10:23 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 9BD481FF14;
        Thu,  4 Apr 2019 17:10:23 +0200 (CEST)
Subject: Re: [PATCHv7 0/6] Add coresight support for SDM845, MSM8998 and
 MSM8996
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <eb744bf9-5966-f7c1-62bb-6806c9aac34e@free.fr>
Date:   Thu, 4 Apr 2019 17:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr  4 17:10:23 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Trim recipients to minimize noise]

On 01/02/2019 01:53, Sai Prakash Ranjan wrote:

> This patch series adds support for coresight on SDM845, MSM8998, and MSM8996.
> 
> * Patch 1 adds device tree nodes for SDM845 coresight components.
> 
> * Patch 2 adds device tree nodes for MSM8998 coresight components.
> 
> * Patch 3 adds device tree nodes for MSM8996 coresight components.
> 
> * Patch 4 enables support for ETMv4.2 and enables SDM845 to make
>   use of same driver(etm4x).
> 
> * Patch 5 adds ETM PIDs for SDM845 and MSM8996.
> 
> * Patch 6 adds coresight CPU debug module for Qualcomm Kryo.
> 
> NOTE: All the dependent patches are applied in the below tree,
>       the first 12 commits represent the dependent patches.
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
> 
> Patch 1 and 4 depends on below AOSS QMP, AMBA bus pclk and address cell change:
>  * https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/
>  * https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/
>  * https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/
>  * https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/
>  * https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/
>  * https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> 
> Patch 2 depends on MSM8998 rpm clocks and rpmcc nodes:
>  * https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
>  * https://lore.kernel.org/lkml/1548866144-30265-1-git-send-email-jhugo@codeaurora.org/
>  * https://lore.kernel.org/lkml/6da00186-e7c9-c93d-a80a-65eda2516451@free.fr/
> 
> Patch 5 and 6 depends on UCI support by Mike Leach:
>  * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/ 
> 
> This patch series has been tested on SDM845 MTP and MSM8996
> based Dragonboard 820c and MSM8998 MTP.
> 
> v7:
>  * Change uci_id_debug struct to const.
>  * Update the subject as suggested by Suzuki.
> 
> v6:
>  * Update the UCI table with the new macro introduced by
>    Mike.
>  * Rebase on top of coresight-next and provide a tree with
>    all the dependent patches applied.
> 
> v5:
>  * Added coresight support for MSM8998.
>  * Added ETM PIDs for SDM845 and MSM8996 as suggested
>    by Suzuki.
>  * Added UCI table for Coresight CPU debug module.
> 
> v4:
>  * Mask out the minor version as suggested by Mathieu.
>  * Added the dependent patch description in patch 1.
> 
> v3:
>  * Added arm,scatter-gather property as suggested by Suzuki.
> 
> v2:
>  * Added coresight support for msm8996 based on Vivek's patch.
>    Cleaned up and added coresight cpu debug nodes for msm8996.
>  * Merged coresight dtsi file into sdm845.dtsi as suggested by Bjorn
>  * Addressed Mathieu's feedback about masking the minor version in
>    etm4_arch_supported() and added a comment for reason to bypass
>    the AMBA bus discovery method.
> 
> Sai Prakash Ranjan (5):
>   arm64: dts: qcom: sdm845: Add Coresight support
>   arm64: dts: qcom: msm8998: Add Coresight support
>   coresight: etm4x: Add support to enable ETMv4.2
>   coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
>   coresight: cpu-debug: Add support for Qualcomm Kryo
> 
> Vivek Gautam (1):
>   arm64: dts: qcom: msm8996: Add Coresight support
> 
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         | 434 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         | 435 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 434 +++++++++++++++++
>  .../hwtracing/coresight/coresight-cpu-debug.c |  33 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c |  17 +-
>  5 files changed, 1330 insertions(+), 23 deletions(-)

It appears that only patch 4 has been picked up?
(I'm on next-20190401)

$ git ls --grep='arm64: dts: qcom: sdm845: Add Coresight support' --grep='arm64: dts: qcom: msm8996: Add Coresight support' --grep='arm64: dts: qcom: msm8998: Add Coresight support' --grep='coresight: etm4x: Add support to enable ETMv4.2' --grep='coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996' --grep='coresight: cpu-debug: Add support for Qualcomm Kryo'

5666dfd1d8a4 coresight: etm4x: Add support to enable ETMv4.2

Bjorn, I think the arch/arm64/boot/dts/qcom patches are for you?

Mathieu/Suzuki, the remaining 2 would be for you?

Regards.
