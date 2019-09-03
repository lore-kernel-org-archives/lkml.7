Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9122D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lwiyvBbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfICJeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:34:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728176AbfICJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:34:04 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x839VrvX030659;
        Tue, 3 Sep 2019 11:33:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=1hZGIsGfyERsa3NufDeV2SKkYjqJpIXMRAosUgocbx8=;
 b=lwiyvBbRml0BNKMY5JPTsdrx5xxSUkyKViXWkdNbuRa0lzWeNnJ3q+QnJQG7Cu27QaHn
 ehsz3jEpeu5qsBxZBKZQrBllJcvooDXMXXsIYrhx4tCUgKn4W9SEBDcBIEKT3nernxVK
 SuxIbccmekZlCwHAJ3YtZt/o9X3CI8pCDyxfU//KV1rlIRtD4CCZn0vNFdfK1ra5ij08
 NfuuVDfZaX7woAncK4DMuLBfU5FrsiB92yhGymv1tXS2cs4b5jdsMrkCwElMkm4U7yYs
 i83cKdGCdVYWhxkx1CoeQdRddHM2qORmimVWj91McrmkH5kVmHspE32O0t0ZJp+5UzIN Zg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uqfshsq99-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 03 Sep 2019 11:33:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3F83957;
        Tue,  3 Sep 2019 09:33:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 768E02C1ED4;
        Tue,  3 Sep 2019 11:33:51 +0200 (CEST)
Received: from [10.48.0.131] (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Sep
 2019 11:33:50 +0200
Subject: Re: [PATCH v2] rpmsg: add a description field
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Xiang Xiao <xiaoxiang@xiaomi.com>
References: <20190815231448.10100-1-s-anna@ti.com>
 <3d70ae75-4c62-f310-37fa-8c57bfc09dc1@st.com>
 <351bbba8-e2c6-a195-93fe-d6ed87a9fe79@ti.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <bf847c2c-1d84-556d-0dfa-7b7fa697ce2a@st.com>
Date:   Tue, 3 Sep 2019 11:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <351bbba8-e2c6-a195-93fe-d6ed87a9fe79@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

Sorry for the delay in replying...

On 8/28/19 11:37 PM, Suman Anna wrote:
> Hi Arnaud,
> 
> On 8/27/19 8:58 AM, Arnaud Pouliquen wrote:
>> Hi Suman,
>>
>> On 8/16/19 1:14 AM, Suman Anna wrote:
>>> From: Ohad Ben-Cohen <ohad@wizery.com>
>>>
>>> Add a new description field to the rpmsg bus infrastructure
>>> that can be passed onto the rpmsg client drivers for additional
>>> information. The current rpmsg bus client drivers need to have
>>> a fixed id_table for proper matching, this new field can allow
>>> flexibility for the client drivers (eg: like creating unique
>>> cdevs).
>>>
>>> The description field is published through an enhanced name
>>> service announcement message structure. The name service
>>> message processing logic is updated to maintain backward
>>> compatibility with the previous message structure.
>>
>> Could you give some concrete use cases associated with your need?.
>> I'm not sure I'm interpreting it correctly...
> 
> I have a generic rpmsg-rpc driver that allows userspace to execute any
> of a set of remote functions provided by a service. And we can have the
> same set of functions exported from different rprocs, or different
> services presenting different sets of functions. And the same service is
> used by multiple applications through their own fds. I use the desc
> field to differentiate between the services.

Thanks, this help me to understand the need. Very interesting feature, 
do you plan to upstream it? :)

> 
>>
>> Your patch seems to me a way to create a kind of sub-service. Why not
>> simply concatenate this in the name services, i.e creating several name
>> services ("service-0", "service-1"...)?
> 
> Every-time a new service is added, it requires a driver update adding
> the new service name to the compatible list, or a corresponding udev
> rule. It is really upto the individual rpmsg driver as to how it uses
> the desc field, so it is optional as far as a rpmsg driver is concerned
> (since this didn't exist previously, and so all existing drivers will
> continue to work as before).
> 

>>
>> Regarding your implementation, the descriptor field seems used to:
>> - instantiate a rpmsg service
>> - retrieve the instance from the userland based on the descriptor.
>>
>> What not just use this descriptor to provide information to userland via
>> sysfs, but not use it as a criteria to find the rpmsg device?
> 
> The rpmsg device logic for actually probing a rpmsg driver still relies
> on the name field. I added the additional check against desc to just
> ensure that there are no name clashes on the desc field. Do you have any
> concerns with this check?

First be sure that I understand and agree with the need to have a more 
dynamic way of managing the services. My concerns is more about the way 
to implement it. In my view the need corresponds to the introduction of 
a kind of sub-services to instantiate a service, plus a way to identify 
the sub service. Adding a second field is one solution, but seems to me 
a duplication of the service name. And i have also in mind the OpenAMP 
lib that should support this extra field, with footprint impact.

Xiang Xiao from Xiaomi company proposed an alternative patch a few 
months ago: https://patchwork.kernel.org/patch/10791741/.
The idea is let the driver to check the device match. In this case it 
could support "dynamic" name service. A service name could be a 
concatenation of the basic service name + a descriptor.

Could this patch answer to your need? IMHO, I would prefer this solution 
that gives advantage to not extend the message protocol for NS announcement.

Regards,
Arnaud

> 
>>
>> In this case you can use the remote endpoint address(dst addr) to
>> instantiate the service. The descriptor field could just be an
>> information to help application to retrieve the good instance of the
>> service.
>>
>>>
>>> Based on an initial patch from Ohad Ben-Cohen.
>>>
>>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>>> [s-anna@ti.com: forward port, add sysfs documentation, fixup qcom
>>> drivers]
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> [t-kristo@ti.com: reworked to support both rpmsg with/without the desc
>>> field]
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>> v2:
>>>    - Localized the desc match check to virtio-rpmsg-bus
>>>    - Enforced NULL termination of desc similar to name
>>> v1: https://patchwork.kernel.org/patch/11087717/
>>>    Documentation/ABI/testing/sysfs-bus-rpmsg | 29 ++++++++++
>>>    drivers/rpmsg/qcom_glink_native.c         |  1 +
>>>    drivers/rpmsg/qcom_smd.c                  |  1 +
>>>    drivers/rpmsg/rpmsg_char.c                |  1 +
>>>    drivers/rpmsg/rpmsg_core.c                |  2 +
>>>    drivers/rpmsg/virtio_rpmsg_bus.c          | 67 +++++++++++++++++++++--
>>>    drivers/soc/qcom/wcnss_ctrl.c             |  1 +
>>>    include/linux/rpmsg.h                     |  4 ++
>>>    8 files changed, 101 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-rpmsg
>>> b/Documentation/ABI/testing/sysfs-bus-rpmsg
>>> index 990fcc420935..7f1b09ecc64d 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-rpmsg
>>> +++ b/Documentation/ABI/testing/sysfs-bus-rpmsg
>>> @@ -93,3 +93,32 @@ Description:
>>>            This sysfs entry allows the rpmsg driver for a rpmsg device
>>>            to be specified which will override standard OF, ID table
>>>            and name matching.
>>> +
>>> +What:        /sys/bus/rpmsg/devices/.../desc
>>> +Date:        August 2019
>>> +KernelVersion:    5.4
>>> +Contact:    Bjorn Andersson <bjorn.andersson@linaro.org>
>>> +Description:
>>> +        Every rpmsg device is a communication channel with a remote
>>> +        processor. Channels are identified by a textual name (see
>>> +        /sys/bus/rpmsg/devices/.../name above) and have a local
>>> +        ("source") rpmsg address, and remote ("destination") rpmsg
>>> +        address.
>>> +
>>> +        A channel is first created when an entity, whether local
>>> +        or remote, starts listening on it for messages (and is thus
>>> +        called an rpmsg server). When that happens, a "name service"
>>> +        announcement is sent to the other processor, in order to let
>>> +        it know about the creation of the channel (this way remote
>>> +        clients know they can start sending messages).
>>> +
>>> +        The listening entity (or client) which communicates with a
>>> +        remote processor is referred as rpmsg driver. The rpmsg device
>>> +        and rpmsg driver are matched based on rpmsg device name (see
>>> +        /sys/bus/rpmsg/devices/.../name above) and rpmsg driver ID
>>> table.
>>> +
>>> +        This sysfs entry contains an additional optional description of
>>> +        the rpmsg device that can be optionally included as part of the
>>> +        "name service" announcement. This description is then passed on
>>> +        to the corresponding rpmsg drivers to further distinguish
>>> multiple
>>> +        devices associated with the same rpmsg driver.
>>> diff --git a/drivers/rpmsg/qcom_glink_native.c
>>> b/drivers/rpmsg/qcom_glink_native.c
>>> index f46c787733e8..cfdabddc15ac 100644
>>> --- a/drivers/rpmsg/qcom_glink_native.c
>>> +++ b/drivers/rpmsg/qcom_glink_native.c
>>> @@ -1456,6 +1456,7 @@ static void qcom_glink_rx_close(struct
>>> qcom_glink *glink, unsigned int rcid)
>>>            strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
>>>            chinfo.src = RPMSG_ADDR_ANY;
>>>            chinfo.dst = RPMSG_ADDR_ANY;
>>> +        chinfo.desc[0] = '\0';
>>>              rpmsg_unregister_device(glink->dev, &chinfo);
>>>        }
>>> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
>>> index 4abbeea782fa..7cd6b9c47065 100644
>>> --- a/drivers/rpmsg/qcom_smd.c
>>> +++ b/drivers/rpmsg/qcom_smd.c
>>> @@ -1307,6 +1307,7 @@ static void qcom_channel_state_worker(struct
>>> work_struct *work)
>>>            strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
>>>            chinfo.src = RPMSG_ADDR_ANY;
>>>            chinfo.dst = RPMSG_ADDR_ANY;
>>> +        chinfo.desc[0] = '\0';
>>>            rpmsg_unregister_device(&edge->dev, &chinfo);
>>>            channel->registered = false;
>>>            spin_lock_irqsave(&edge->channels_lock, flags);
>>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>>> index eea5ebbb5119..4bd91445a2fd 100644
>>> --- a/drivers/rpmsg/rpmsg_char.c
>>> +++ b/drivers/rpmsg/rpmsg_char.c
>>> @@ -442,6 +442,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp,
>>> unsigned int cmd,
>>>        chinfo.name[RPMSG_NAME_SIZE-1] = '\0';
>>>        chinfo.src = eptinfo.src;
>>>        chinfo.dst = eptinfo.dst;
>>> +    chinfo.desc[0] = '\0';
>>>          return rpmsg_eptdev_create(ctrldev, chinfo);
>>>    };
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index ea88fd4e2a6e..ba0f2c1a7fa4 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -365,6 +365,7 @@ static DEVICE_ATTR_RW(field)
>>>      /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
>>>    rpmsg_show_attr(name, id.name, "%s\n");
>>> +rpmsg_show_attr(desc, desc, "%s\n");
>>>    rpmsg_show_attr(src, src, "0x%x\n");
>>>    rpmsg_show_attr(dst, dst, "0x%x\n");
>>>    rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
>>> @@ -386,6 +387,7 @@ static DEVICE_ATTR_RO(modalias);
>>>      static struct attribute *rpmsg_dev_attrs[] = {
>>>        &dev_attr_name.attr,
>>> +    &dev_attr_desc.attr,
>>>        &dev_attr_modalias.attr,
>>>        &dev_attr_dst.attr,
>>>        &dev_attr_src.attr,
>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
>>> b/drivers/rpmsg/virtio_rpmsg_bus.c
>>> index 5d3685bd76a2..b42277cd7759 100644
>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>> @@ -110,6 +110,23 @@ struct rpmsg_ns_msg {
>>>        u32 flags;
>>>    } __packed;
>>>    +/**
>>> + * struct rpmsg_ns_msg_ext - dynamic name service announcement
>>> message v2
>>> + * @name: name of remote service that is published
>>> + * @desc: description of remote service
>>> + * @addr: address of remote service that is published
>>> + * @flags: indicates whether service is created or destroyed
>>> + *
>>> + * Interchangeable nameservice message with rpmsg_ns_msg. This one has
>>> + * the addition of the desc field for extra flexibility.
>>> + */
>>> +struct rpmsg_ns_msg_ext {
>>> +    char name[RPMSG_NAME_SIZE];
>>> +    char desc[RPMSG_NAME_SIZE];
>>> +    u32 addr;
>>> +    u32 flags;
>>> +} __packed;
>>> +
>>>    /**
>>>     * enum rpmsg_ns_flags - dynamic name service announcement flags
>>>     *
>>> @@ -384,6 +401,24 @@ static void virtio_rpmsg_release_device(struct
>>> device *dev)
>>>        kfree(vch);
>>>    }
>>>    +static int virtio_rpmsg_desc_match(struct device *dev, void *data)
>>> +{
>>> +    struct rpmsg_channel_info *chinfo = data;
>>> +    struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>>> +
>>> +    if (!*chinfo->desc)
>>> +        return 0;
>>> +
>>> +    if (strncmp(chinfo->name, rpdev->id.name, RPMSG_NAME_SIZE))
>>> +        return 0;
>>> +
>>> +    if (strncmp(chinfo->desc, rpdev->desc, RPMSG_NAME_SIZE))
>>> +        return 0;
>>> +
>>> +    /* found a match ! */
>>> +    return 1;
>>> +}
>>> +
>>>    /*
>>>     * create an rpmsg channel using its name and address info.
>>>     * this function will be used to create both static and dynamic
>>> @@ -407,6 +442,15 @@ static struct rpmsg_device
>>> *rpmsg_create_channel(struct virtproc_info *vrp,
>>>            return NULL;
>>>        }
>>>    +    tmp = device_find_child(dev, chinfo, virtio_rpmsg_desc_match);
>>> +    if (tmp) {
>>> +        /* decrement the matched device's refcount back */
>>> +        put_device(tmp);
>>> +        dev_err(dev, "channel %s:%x:%x failed, desc '%s' already
>>> exists\n",
>>> +            chinfo->name, chinfo->src, chinfo->dst, chinfo->desc);
>>> +        return NULL;
>>> +    }
>>> +
>>>        vch = kzalloc(sizeof(*vch), GFP_KERNEL);
>>>        if (!vch)
>>>            return NULL;
>>> @@ -419,6 +463,7 @@ static struct rpmsg_device
>>> *rpmsg_create_channel(struct virtproc_info *vrp,
>>>        rpdev->src = chinfo->src;
>>>        rpdev->dst = chinfo->dst;
>>>        rpdev->ops = &virtio_rpmsg_ops;
>>> +    strncpy(rpdev->desc, chinfo->desc, RPMSG_NAME_SIZE);
>>>          /*
>>>         * rpmsg server channels has predefined local address (for now),
>>> @@ -816,18 +861,30 @@ static int rpmsg_ns_cb(struct rpmsg_device
>>> *rpdev, void *data, int len,
>>>                   void *priv, u32 src)
>>>    {
>>>        struct rpmsg_ns_msg *msg = data;
>>> +    struct rpmsg_ns_msg_ext *msg_ext = data;
>>>        struct rpmsg_device *newch;
>>>        struct rpmsg_channel_info chinfo;
>>>        struct virtproc_info *vrp = priv;
>>>        struct device *dev = &vrp->vdev->dev;
>>>        int ret;
>>> +    u32 addr;
>>> +    u32 flags;
>>>      #if defined(CONFIG_DYNAMIC_DEBUG)
>>>        dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
>>>                 data, len, true);
>>>    #endif
>>>    -    if (len != sizeof(*msg)) {
>>> +    if (len == sizeof(*msg)) {
>>> +        addr = msg->addr;
>>> +        flags = msg->flags;
>>> +        chinfo.desc[0] = '\0';
>>> +    } else if (len == sizeof(*msg_ext)) {
>>> +        addr = msg_ext->addr;
>>> +        flags = msg_ext->flags;
>>> +        msg_ext->desc[RPMSG_NAME_SIZE - 1] = '\0';
>>> +        strncpy(chinfo.desc, msg_ext->desc, sizeof(chinfo.desc));
>>> +    } else {
>>>            dev_err(dev, "malformed ns msg (%d)\n", len);
>>>            return -EINVAL;
>>>        }
>>> @@ -847,14 +904,14 @@ static int rpmsg_ns_cb(struct rpmsg_device
>>> *rpdev, void *data, int len,
>>>        msg->name[RPMSG_NAME_SIZE - 1] = '\0';
>>>          dev_info(dev, "%sing channel %s addr 0x%x\n",
>>> -         msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
>>> -         msg->name, msg->addr);
>>> +         flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
>>> +         msg->name, addr);
>>>          strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>>>        chinfo.src = RPMSG_ADDR_ANY;
>>> -    chinfo.dst = msg->addr;
>>> +    chinfo.dst = addr;
>>>    -    if (msg->flags & RPMSG_NS_DESTROY) {
>>> +    if (flags & RPMSG_NS_DESTROY) {
>>>            ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
>>>            if (ret)
>>>                dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
>>> diff --git a/drivers/soc/qcom/wcnss_ctrl.c
>>> b/drivers/soc/qcom/wcnss_ctrl.c
>>> index e5c68051fb17..ad9f28dc13f1 100644
>>> --- a/drivers/soc/qcom/wcnss_ctrl.c
>>> +++ b/drivers/soc/qcom/wcnss_ctrl.c
>>> @@ -276,6 +276,7 @@ struct rpmsg_endpoint
>>> *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
>>>        strscpy(chinfo.name, name, sizeof(chinfo.name));
>>>        chinfo.src = RPMSG_ADDR_ANY;
>>>        chinfo.dst = RPMSG_ADDR_ANY;
>>> +    chinfo.desc[0] = '\0';
>>>          return rpmsg_create_ept(_wcnss->channel->rpdev, cb, priv,
>>> chinfo);
> 
>> There is another way to create a service, by registering an RPMsg
>> drivers (e.g.
>> https://elixir.bootlin.com/linux/v5.3-rc6/source/samples/rpmsg/rpmsg_client_sample.c)
> 
> I am not sure I understand, you obviously need a rpmsg driver for a
> rpmsg device to probe.
> 
>>
>> In this case the descriptor can not be used, right?
>> To be compliant probably need to extend the rpmsg_device_id struct...
> 
> As I mentioned above, it is optional for backward compatibility, and the
> rpmsg client sample doesn't have any use for it atm, even if a firmware
> publishes a desc field alongside the "rpmsg-client-sample" name. That is
> why, I haven't extended the rpmsg_device_id.
> 
> regards
> Suman
> 
>>
>> Regards,
>> Arnaud
>>>    }
>>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>> index 9fe156d1c018..436faf04ba1c 100644
>>> --- a/include/linux/rpmsg.h
>>> +++ b/include/linux/rpmsg.h
>>> @@ -28,11 +28,13 @@ struct rpmsg_endpoint_ops;
>>>    /**
>>>     * struct rpmsg_channel_info - channel info representation
>>>     * @name: name of service
>>> + * @desc: description of service
>>>     * @src: local address
>>>     * @dst: destination address
>>>     */
>>>    struct rpmsg_channel_info {
>>>        char name[RPMSG_NAME_SIZE];
>>> +    char desc[RPMSG_NAME_SIZE];
>>>        u32 src;
>>>        u32 dst;
>>>    };
>>> @@ -42,6 +44,7 @@ struct rpmsg_channel_info {
>>>     * @dev: the device struct
>>>     * @id: device id (used to match between rpmsg drivers and devices)
>>>     * @driver_override: driver name to force a match
>>> + * @desc: description of remote service
>>>     * @src: local address
>>>     * @dst: destination address
>>>     * @ept: the rpmsg endpoint of this channel
>>> @@ -51,6 +54,7 @@ struct rpmsg_device {
>>>        struct device dev;
>>>        struct rpmsg_device_id id;
>>>        char *driver_override;
>>> +    char desc[RPMSG_NAME_SIZE];
>>>        u32 src;
>>>        u32 dst;
>>>        struct rpmsg_endpoint *ept;
>>>
> 
