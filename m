Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72224C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A59E207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfLDP1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:27:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbfLDP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:27:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FNO27122847;
        Wed, 4 Dec 2019 10:26:34 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnp8t2hjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 10:26:34 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4FP6g0021426;
        Wed, 4 Dec 2019 15:26:33 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2wkg26yxgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 15:26:33 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4FQWwg53018974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 15:26:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3ED11206E;
        Wed,  4 Dec 2019 15:26:32 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12316112063;
        Wed,  4 Dec 2019 15:26:31 +0000 (GMT)
Received: from [9.163.41.206] (unknown [9.163.41.206])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 15:26:30 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 07/12] drivers/soc: xdma: Add user interface
To:     Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        maz@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        tglx@linutronix.de, Rob Herring <robh+dt@kernel.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
 <3de1107b-59e6-48a6-90a0-704f0ebf70da@www.fastmail.com>
 <d096ccaa-1ee5-24f2-d510-04339c131ad8@linux.vnet.ibm.com>
 <2bab457b-a66e-4b40-949a-fda8b5ec69c0@www.fastmail.com>
Message-ID: <9f2f1d28-dea4-935c-bf97-ca445bf50305@linux.ibm.com>
Date:   Wed, 4 Dec 2019 09:26:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2bab457b-a66e-4b40-949a-fda8b5ec69c0@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/19 9:30 PM, Andrew Jeffery wrote:
> On Tue, 26 Nov 2019, at 06:14, Eddie James wrote:
>> On 11/24/19 5:59 PM, Andrew Jeffery wrote:
>>> On Sat, 9 Nov 2019, at 06:48, Eddie James wrote:
>>>> This commits adds a miscdevice to provide a user interface to the XDMA
>>>> engine. The interface provides the write operation to start DMA
>>>> operations. The DMA parameters are passed as the data to the write call.
>>>> The actual data to transfer is NOT passed through write. Note that both
>>>> directions of DMA operation are accomplished through the write command;
>>>> BMC to host and host to BMC.
>>>>
>>>> The XDMA engine is restricted to only accessing the reserved memory
>>>> space on the AST2500, typically used by the VGA. For this reason, the
>>>> VGA memory space is pooled and allocated with genalloc. Users calling
>>>> mmap allocate pages from this pool for their usage. The space allocated
>>>> by a client will be the space used in the DMA operation. For an
>>>> "upstream" (BMC to host) operation, the data in the client's area will
>>>> be transferred to the host. For a "downstream" (host to BMC) operation,
>>>> the host data will be placed in the client's memory area.
>>>>
>>>> Poll is also provided in order to determine when the DMA operation is
>>>> complete for non-blocking IO.
>>>>
>>>> Signed-off-by: Eddie James<eajames@linux.ibm.com>
>>>> ---
>>>>    drivers/soc/aspeed/aspeed-xdma.c | 223 +++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 223 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
>>>> index 99041a6..3d37582 100644
>>>> --- a/drivers/soc/aspeed/aspeed-xdma.c
>>>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>>>> @@ -64,6 +64,9 @@
>>>>    #define XDMA_CMDQ_SIZE				PAGE_SIZE
>>>>    #define XDMA_NUM_CMDS				\
>>>>    	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
>>>> +#define XDMA_OP_SIZE_MAX			sizeof(struct aspeed_xdma_op)
>>>> +#define XDMA_OP_SIZE_MIN			\
>>>> +	(sizeof(struct aspeed_xdma_op) - sizeof(u64))
>>>>    
>>>>    /* Aspeed specification requires 10ms after switching the reset line */
>>>>    #define XDMA_RESET_TIME_MS			10
>>>> @@ -216,6 +219,7 @@ struct aspeed_xdma {
>>>>    	bool in_reset;
>>>>    	bool upstream;
>>>>    	unsigned int cmd_idx;
>>>> +	struct mutex file_lock;
>>> Please add documentation about what data file_lock is protecting.
>>>
>>>>    	struct mutex start_lock;
>>>>    	struct delayed_work reset_work;
>>>>    	spinlock_t client_lock;
>>>> @@ -230,6 +234,8 @@ struct aspeed_xdma {
>>>>    	dma_addr_t cmdq_vga_phys;
>>>>    	void *cmdq_vga_virt;
>>>>    	struct gen_pool *vga_pool;
>>>> +
>>>> +	struct miscdevice misc;
>>>>    };
>>>>    
>>>>    struct aspeed_xdma_client {
>>>> @@ -557,6 +563,204 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq,
>>>> void *arg)
>>>>    	return IRQ_HANDLED;
>>>>    }
>>>>    
>>>> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
>>>> +				 size_t len, loff_t *offset)
>>>> +{
>>>> +	int rc;
>>>> +	struct aspeed_xdma_op op;
>>>> +	struct aspeed_xdma_client *client = file->private_data;
>>>> +	struct aspeed_xdma *ctx = client->ctx;
>>>> +	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
>>>> +		XDMA_CMDQ_SIZE;
>>>> +
>>>> +	if (len < XDMA_OP_SIZE_MIN)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (len > XDMA_OP_SIZE_MAX)
>>>> +		len = XDMA_OP_SIZE_MAX;
>>> Isn't this an EINVAL case as well?
>> Perhaps so.
>>
>>
>>>> +
>>>> +	rc = copy_from_user(&op, buf, len);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	if (op.direction == ASPEED_XDMA_DIRECTION_RESET) {
>>> Seems a bit abusive to use the direction field to issue a reset.
>> What would you recommend instead?
> Looks like an ioctl() to me. But what need do we have to directly reset
> the device? Could we achieve the same by rebinding the driver if
> necessary? We should only need to reset it if the driver has bugs, or
> is there some errata that we need to deal with? Userspace shouldn't
> be handling that though?


Well it could be necessary to reset if userspace messes up and sends a 
bad host address for example, so that's why I'd like to have it 
available to userspace.


>>>> +		mutex_lock(&ctx->start_lock);
>>>> +
>>>> +		if (aspeed_xdma_reset_start(ctx)) {
>>>> +			msleep(XDMA_RESET_TIME_MS);
>>>> +
>>>> +			aspeed_xdma_reset_finish(ctx);
>>>> +		}
>>>> +
>>>> +		mutex_unlock(&ctx->start_lock);
>>>> +
>>>> +		return len;
>>>> +	} else if (op.direction > ASPEED_XDMA_DIRECTION_RESET) {
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (op.len > ctx->vga_size - offs)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (file->f_flags & O_NONBLOCK) {
>>>> +		if (!mutex_trylock(&ctx->file_lock))
>>>> +			return -EAGAIN;
>>>> +
>>>> +		if (ctx->in_progress || ctx->in_reset) {
>>> ctx->in_progress was protected by a lock that isn't file_lock, so this looks wrong.
>> file_lock isn't protecting in_progress. It's protecting access to the
>> whole engine while a transfer is in progress.
> Then when would we ever gain file_lock if in_progress was set? Shouldn't the current
> client hold file_lock until we'd set in_progress to false, in which case we wouldn't
> need to check in_progress if we now hold the lock?


That doesn't work for non-blocking io.


>> in_progress isn't protected at all,
> Except it is, because you've acquired file_lock above before checking it (and
> in_reset).
>
> And why is in_progress written to under ctx->start_lock (which is not file_lock)
> in aspeed_xdma_start() in the earlier patch if it's not protected?


OK, I just didn't quite get what you meant by protected. Yes, multiple 
reads here of in_progress must be serialized so that only one thread 
sees it go false at once. This prevents multiple transfers from being 
started while one is in progress. But writing it doesn't require locking 
that I can see.


>> it's just better to lock
> There's never a case of "it's just better to lock", as if it were optional. Either the
> variable needs to be protected against concurrent access or it doesn't. If it does,
> always access it under a consistent lock.


Not what I meant, was trying to say better to lock before waiting 
(rather than after). However now that I think again, that wouldn't work 
to prevent multiple transfers being started while one is in progress.


>> before waiting for
>> in_progress so that multiple clients don't all see in_progress go false
>> and have to wait for a mutex (particularly in the nonblocking case).
> Yes, so what you're suggesting is that in_progress needs to be protected against
> concurrent access, so needs to be accessed under a consistent lock. Though as
> suggested above it might be enough to successfully acquire file_lock.
> As far as I can see we have three events that we need to care about:
>
> 1. Submission of a DMA request
> 2. Completion of a DMA request
> 3. PCIe-driven reset
>
> For 1, multiple concurrent submissions need to be serialised, so we need a
> mutex with the semantics of file_lock as you've described above.
>
> 2 should only occur if we have an event of type 1 outstanding. If 1 is outstanding
> then receiving 2 should cause the process that triggered 1 to wake and release
> the mutex.


This gets more complicated than that because we need non-blocking io; 
the mutex can't be held while the client call exits with EAGAIN.


> 3 can happen at any time which results in two cases that we need to care about:
>
> 3a. DMA request in progress (i.e. 1 but have not yet seen corresponding 2)
> 3b. DMA idle (no request in progress)
>
> Events of type 1 need to be serialised against 3. 2 won't occur after 3 until 1 has
> occurred, so there's no need to consider it in the serialisation for 3.
>
> In the case of 3a. we need to reset the device, then mark the current transfer failed,
> then wake the associated process. The woken process will release the mutex and
> allow any queued requests to proceed.
>
> 3b is much simpler, though we need to prevent events of type 1 concurrently
> accessing the device while the reset is in progress. So we need a spinlock to cover
> configuring the device.
>
> So that's two locks - a mutex to serialise process-context access to the device, and
> a spinlock to serialise interrupts with respect to process-context access. Currently
> your implementation contains two mutexes (start_lock and file_lock) and two
> spinlocks (client_lock and reset_lock), all with fairly hazy definitions.
>
>>>> +			mutex_unlock(&ctx->file_lock);
>>>> +			return -EAGAIN;
>>>> +		}
>>>> +	} else {
>>>> +		mutex_lock(&ctx->file_lock);
>>>> +
>>>> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress &&
>>>> +					      !ctx->in_reset);
>>> As above.
>>>
>>>> +		if (rc) {
>>>> +			mutex_unlock(&ctx->file_lock);
>>>> +			return -EINTR;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
>>>> +
>>>> +	mutex_unlock(&ctx->file_lock);
>>>> +
>>>> +	if (!(file->f_flags & O_NONBLOCK)) {
>>>> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress);
>>>> +		if (rc)
>>>> +			return -EINTR;
>>>> +
>>>> +		if (client->error)
>>>> +			return -EIO;
>>> What's the client->error value? Can it be more informative?
>> Not really. There isn't much error information available. Basically the
>> only way to get an error is if the engine is reset (user or PCIE
>> initiated) while the transfer is on-going.
>>
>>
>>>> +	}
>>>> +
>>>> +	return len;
>>> We've potentially truncated len above (in the len >  XDMA_OP_SIZE_MAX),
>>> which leads to some ambiguity with the write() syscall given that it can
>>> potentially return less than the requested length. This is one such case, but
>>> the caller probably shouldn't attempt a follow-up write.
>>>
>>> This would go away if we make the len > XDMA_OP_SIZE_MAX an EINVAL
>>> case as suggested agove.
>> Sure.
>>
>>
>>>> +}
>>>> +
>>>> +static __poll_t aspeed_xdma_poll(struct file *file,
>>>> +				 struct poll_table_struct *wait)
>>>> +{
>>>> +	__poll_t mask = 0;
>>>> +	__poll_t req = poll_requested_events(wait);
>>>> +	struct aspeed_xdma_client *client = file->private_data;
>>>> +	struct aspeed_xdma *ctx = client->ctx;
>>>> +
>>>> +	if (req & (EPOLLIN | EPOLLRDNORM)) {
>>>> +		if (client->in_progress)
>>>> +			poll_wait(file, &ctx->wait, wait);
>>>> +
>>>> +		if (!client->in_progress) {
>>>> +			if (client->error)
>>>> +				mask |= EPOLLERR;
>>>> +			else
>>>> +				mask |= EPOLLIN | EPOLLRDNORM;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (req & (EPOLLOUT | EPOLLWRNORM)) {
>>>> +		if (ctx->in_progress)
>>>> +			poll_wait(file, &ctx->wait, wait);
>>>> +
>>>> +		if (!ctx->in_progress)
>>>> +			mask |= EPOLLOUT | EPOLLWRNORM;
>>>> +	}
>>>> +
>>>> +	return mask;
>>>> +}
>>>> +
>>>> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
>>>> +{
>>>> +	struct aspeed_xdma_client *client = vma->vm_private_data;
>>>> +
>>>> +	gen_pool_free(client->ctx->vga_pool, (unsigned long)client->virt,
>>>> +		      client->size);
>>>> +
>>>> +	client->virt = NULL;
>>>> +	client->phys = 0;
>>>> +	client->size = 0;
>>>> +}
>>>> +
>>>> +static const struct vm_operations_struct aspeed_xdma_vm_ops = {
>>>> +	.close =	aspeed_xdma_vma_close,
>>>> +};
>>>> +
>>>> +static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
>>>> +{
>>>> +	int rc;
>>>> +	struct aspeed_xdma_client *client = file->private_data;
>>>> +	struct aspeed_xdma *ctx = client->ctx;
>>>> +
>>>> +	/* restrict file to one mapping */
>>>> +	if (client->size)
>>>> +		return -ENOMEM;
>>> Can we do better with the error code here?
>> Maybe? I'm open to suggestions...
> How about EBUSY?


Sounds good.


>>>> +
>>>> +	client->size = vma->vm_end - vma->vm_start;
>>>> +	client->virt = gen_pool_dma_alloc(ctx->vga_pool, client->size,
>>>> +					  &client->phys);
>>>> +	if (!client->virt) {
>>>> +		client->phys = 0;
>>>> +		client->size = 0;
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
>>> Where does client->phys get set?
>> gen_pool_dma_alloc sets it.
> Ah, yes. Thanks.
>
> Andrew
