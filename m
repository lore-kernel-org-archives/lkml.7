Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA31206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfCFKJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:09:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9044 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729882AbfCFKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:09:13 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26A7Kx7008334;
        Wed, 6 Mar 2019 11:08:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgay5dn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 11:08:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 814283A;
        Wed,  6 Mar 2019 10:08:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4AEE125E6;
        Wed,  6 Mar 2019 10:08:58 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar
 2019 11:08:57 +0100
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFo_O36=N9wM2jFnUvkga1TFjPMibr+0MRU6bLOpq7nH7g@mail.gmail.com>
 <5b531f55-b8a0-5a83-4a7c-727013a66820@st.com>
 <CAPDyKFp=AO27hmG9u8JHrRa3JW7RNMbxC8+vMb2y_qGo=mLWQg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <15ce68e6-136f-7e9b-553c-968a0653a9b8@st.com>
Date:   Wed, 6 Mar 2019 11:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp=AO27hmG9u8JHrRa3JW7RNMbxC8+vMb2y_qGo=mLWQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf

I could have a snowball board, I don't remember if it a ux500v1 or v2?
This board has been removed of u-boot mainline, do you have a specific
repository for snowball or what branch do you advise?
do you have a snowball wiki (up-to-date) for flashing...

BR
Ludo
On 3/6/19 10:49 AM, Ulf Hansson wrote:
> On Wed, 6 Mar 2019 at 10:04, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> Hi Ulf
>>
>> On 3/6/19 10:00 AM, Ulf Hansson wrote:
>>> On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> The busy status bit could occurred even if no busy response is
>>>> expected (example cmd11). On sdmmc variant, the busy_detect_flag
>>>> reflects inverted value of d0 state, it's sampled at the end of a
>>>> CMD response and a second time 2 clk cycles after the CMD response.
>>>> To avoid a fake busy, the busy status could be checked and polled
>>>> only if the command has RSP_BUSY flag.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Before I review this, can you tell what HW you have tested this on?
>>
>> I tested on stm32mp157c (stm32_sdmmc variant)
> 
> Okay, I see. So we need to get this tested for the ux500v2 variant as
> well. I try to get some time to do that, soon.
> 
> However it seems like you could benefit from having one of those
> boards yourself. It would speed up the process, as you wouldn't have
> to rely on me doing the test. :-) Is there a chance of you could dig
> up some of these old boards from somewhere?
> 
> Kind regards
> Uffe
> 
>>
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> ---
>>>>    drivers/mmc/host/mmci.c | 19 +++++++++++++------
>>>>    1 file changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>> index 387ff14..4901b73 100644
>>>> --- a/drivers/mmc/host/mmci.c
>>>> +++ b/drivers/mmc/host/mmci.c
>>>> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>                unsigned int status)
>>>>    {
>>>>           void __iomem *base = host->base;
>>>> -       bool sbc;
>>>> +       bool sbc, busy_resp;
>>>>
>>>>           if (!cmd)
>>>>                   return;
>>>>
>>>>           sbc = (cmd == host->mrq->sbc);
>>>> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>>>>
>>>>           /*
>>>>            * We need to be one of these interrupts to be considered worth
>>>> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>           /*
>>>>            * ST Micro variant: handle busy detection.
>>>>            */
>>>> -       if (host->variant->busy_detect) {
>>>> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>>>> +       if (busy_resp && host->variant->busy_detect) {
>>>>
>>>>                   /* We are busy with a command, return */
>>>>                   if (host->busy_status &&
>>>> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>>                    * that the special busy status bit is still set before
>>>>                    * proceeding.
>>>>                    */
>>>> -               if (!host->busy_status && busy_resp &&
>>>> +               if (!host->busy_status &&
>>>>                       !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>>>                       (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>>>>
>>>> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>>    {
>>>>           struct mmci_host *host = dev_id;
>>>>           u32 status;
>>>> +       bool busy_resp;
>>>>           int ret = 0;
>>>>
>>>>           spin_lock(&host->lock);
>>>> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>>                   }
>>>>
>>>>                   /*
>>>> -                * Don't poll for busy completion in irq context.
>>>> +                * Don't poll for:
>>>> +                * -busy completion in irq context.
>>>> +                * -no busy response expected.
>>>>                    */
>>>> -               if (host->variant->busy_detect && host->busy_status)
>>>> +               busy_resp = host->cmd ?
>>>> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
>>>> +
>>>> +               if (host->variant->busy_detect &&
>>>> +                   (!busy_resp || host->busy_status))
>>>>                           status &= ~host->variant->busy_detect_flag;
>>>>
>>>>                   ret = 1;
>>>> --
>>>> 2.7.4
>>>>
