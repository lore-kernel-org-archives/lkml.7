Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8526C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70FA2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfLLTQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:16:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730295AbfLLTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:16:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCJBbRX143933;
        Thu, 12 Dec 2019 14:16:27 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrkjtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 14:16:26 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCJCW1T013229;
        Thu, 12 Dec 2019 19:16:26 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2wr3q7ckd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 19:16:26 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCJGPtQ44302744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 19:16:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57242AC059;
        Thu, 12 Dec 2019 19:16:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71FECAC05E;
        Thu, 12 Dec 2019 19:16:24 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 19:16:24 +0000 (GMT)
Subject: Re: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
To:     Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, Joel Stanley <joel@jms.id.au>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
 <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
 <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <bbe9045e-c5ca-541c-1ee9-0f5ef246a27b@linux.vnet.ibm.com>
Date:   Thu, 12 Dec 2019 13:16:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/19 10:52 PM, Andrew Jeffery wrote:
>
> On Thu, 12 Dec 2019, at 07:09, Eddie James wrote:
>> On 12/10/19 9:47 PM, Andrew Jeffery wrote:
>>> On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
>>>> +
>>>> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
>>>> +						struct aspeed_xdma_op *op,
>>>> +						u32 bmc_addr)
>>>> +{
>>>> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
>>>> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
>>>> +	unsigned int line_size;
>>>> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
>>>> +	unsigned int line_no = 1;
>>>> +	unsigned int pitch = 1;
>>>> +	struct aspeed_xdma_cmd *ncmd =
>>>> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
>>>> +
>>>> +	if ((op->host_addr + op->len) & 0xffffffff00000000ULL)
>>> Do we know that this won't wrap?
>>
>> No, but I assume it would be a bad transfer anyway at that point?
> But what happens as a consequence? We would have a 64 bit address
> but wouldn't enable 64bit addressing, so presumably the hardware
> would only use the bottom 32 bits of the address?
>
> Things could get weird yes?
>
> Or is there some failure that would occur before we trigger the transfer?
> Is that what you're depending on?


OK, I'll handle it then.


>
>>>> +
>>>> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
>>>> +{
>>>> +	if (ctx->current_client) {
>>>> +		ctx->current_client->error = error;
>>>> +		ctx->current_client->in_progress = false;
>>>> +		ctx->current_client = NULL;
>>> You need to take start_lock before writing these members to ensure the
>>> writes are not reordered across acquisition of start_lock in
>>> aspeed_xdma_start() above, unless there's some other guarantee of that?
>>
>> Unless we get spurious interrupts (as in, the xdma interrupt fires with
>> no transfer started, and somehow the correct status bits are set), it's
>> not possible to execute this at the same time as aspeed_xdma_start(). So
>> I did not try and lock here. Do you think it's worth locking for that
>> situation?
>>
> Why is it worth not locking? How is it correct? To answer that way we invoke
> all kinds of reasoning about multi-processing (interrupt handled on one core
> while aspeed_xdma_start() is executing on another), value visibility and
> instruction reordering (though as it happens the 2400, 2500 and 2600 are all
> in-order). We'll trip ourselves up if there is eventually a switch to out-of-order
> execution where the writes might be reordered and delayed until after
> start_lock has been acquired in aspeed_xdma_start() by a subseqent transfer.
> This line of reasoning is brittle exploitation of properties of the currently used
> cores for no benefit. Finishing the DMA op isn't a hot path where you might
> want to take some of these risks for performance, so we have almost zero
> care for lock contention but we must always be concerned about correctness.
>
> We avoid invoking all of those questions by acquiring the lock.


OK, I'll refactor to lock it.


>
>>>> +
>>>> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
>>>> +	if (!ctx->vga_pool) {
>>>> +		dev_err(dev, "Failed to setup genalloc pool.\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	rc = of_property_read_u32_array(dev->of_node, "vga-mem", vgamem, 2);
>>> As mentioned, this could be any reserved memory range. Also can't we get it as
>>> a resource rather than parsing a u32 array? Not sure if there's an advantage
>>> but it feels like a better representation.
>>
>> That doesn't work unfortunately because the VGA memory is not mapped and
>> the reserved memory subsystem fails to find it.
> Fair enough.
>
>>>> +
>>>> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
>>>> +			   ctx->chip->sdmc_remap);
>>> I disagree with doing this. As mentioned on the bindings it should be up to
>>> the platform integrator to ensure that this is configured appropriately.
>>
>> Probably so, but then how does one actually configure that elsewhere? Do
>> you mean add code to the edac driver (and add support for the ast2600)
>> to read some dts properties to set it?
> Right. That's where I was going. I don't expect you to do that as part of this
> patch series, but if you could separate this code out into separate patches
> (dealing with the sdmc property in the devicetree binding as well) we can at
> least concentrate on getting the core XDMA driver in and work out how to
> move forward with configuring the memory controller later.


Yea... my concern is that then we end up with a driver upstream that 
doesn't actually work. Same concern with the reset thing you mentioned 
below.


Thanks,

Eddie


>
>>>> +/*
>>>> + * aspeed_xdma_direction
>>>> + *
>>>> + * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
>>>> + *
>>>> + * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
>>>> + *
>>>> + * ASPEED_XDMA_DIRECTION_RESET: resets the XDMA engine
>>>> + */
>>>> +enum aspeed_xdma_direction {
>>>> +	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
>>>> +	ASPEED_XDMA_DIRECTION_UPSTREAM,
>>>> +	ASPEED_XDMA_DIRECTION_RESET,
>>> I still think having a reset action as part of the direction is a bit funky. Can you maybe
>>> put that in a separate patch so we can debate it later?
>>
>> I can, but I'm fairly convinced this is the cleanest way to add the
>> reset functionality.
>>
> Right, but if you separate it out you'll get my reviewed-by on the core XDMA
> patches much quicker :) You can convince me about it in slow-time
>
> Cheers,
>
> Andrew
