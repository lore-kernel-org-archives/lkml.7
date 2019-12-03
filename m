Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B64206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLCC6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:58:02 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:31984 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfLCC6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:58:01 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id xB32v5sP060797;
        Tue, 3 Dec 2019 10:57:05 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id xB32urhs026602;
        Tue, 3 Dec 2019 10:56:53 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 3 Dec 2019
 10:56:54 +0800
Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
To:     "Nath, Arindam" <Arindam.Nath@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
CC:     "S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com> Dave Jiang" 
        <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linjiasen007@gmail.com" <linjiasen007@gmail.com>
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
 <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
 <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
 <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
 <c5adca66-024f-8d37-3187-ffba73102ac4@amd.com>
 <MN2PR12MB323225CC169836056288CAA39C450@MN2PR12MB3232.namprd12.prod.outlook.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <379b9b9f-5b8b-482d-4257-d156780a6fe1@hygon.cn>
Date:   Tue, 3 Dec 2019 10:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB323225CC169836056288CAA39C450@MN2PR12MB3232.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xB32v5sP060797
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/26 22:35, Nath, Arindam wrote:
>> -----Original Message-----
>> From: Mehta, Sanju <Sanju.Mehta@amd.com>
>> Sent: Tuesday, November 26, 2019 18:40
>> To: Jiasen Lin <linjiasen@hygon.cn>
>> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com> Dave Jiang
>> <dave.jiang@intel.com>; Nath, Arindam <Arindam.Nath@amd.com>; Allen
>> Hubbe <allenbh@gmail.com>; linux-kernel <linux-kernel@vger.kernel.org>;
>> linux-ntb <linux-ntb@googlegroups.com>; linjiasen007@gmail.com
>> Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
>>
>>
>>> Hi Sanjay R Mehta
>>>
>>> In more complex topology, read the Link Status and Control register of
>>> RP is also wrong. Suppose that a PCIe switch bridge to the Secondary RP,
>>> and Secondary internal SW.ds is a child device for switch's downstream
>>> port as illustrated in the following topology.
>>>
>>> In secondary PCI domain:
>>> Secondary RP--Switch UP--Switch DP--Secondary internal SW.us--
>> Secondary
>>> internal SW.ds--Secondary NTB
>>>
>>> pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev) will return the
>>> Secondary RP, and pcie_capability_read_dword(pci_rp,
>>> PCI_EXP_LNKCTL,&stat) will get the link status between Secondary RP and
>>> Switch UP. Maybe, read the Link Status and control register of Secondary
>>> internal SW.us is appropriate.
>>>
>> Hi Jiansen Lin,
>>
>> I modified the code as per your suggestion and is working fine.
>> Adding Arindam for comments who was the co-author of the patch I was
>> about to send for upstream review.
> 
> Hi Jiansen Lin,
> 
> I am okay with the changes proposed by you. But one thing we need to keep
> in mind is that, the configuration SWUS+SWDS+EP as visible from the NTB
> secondary, might change in future AMD implementations where these internal
> switches are not present anymore. So we might have to re-visit the patch
> again later.
> 
> Thanks,
> Arindam
> 

Hi Adridam
We can define a depth value that from secondary NTB EP to the real link 
training device for the various devices, if internal switch is not
presnt in future. In amd_poll_link we traverse up the parent chain utill 
the depth is reached.
Now, for device 145b, the depth is defined to 2, because only one
internal switch is implemented for secondary NTB. For device 148b, maybe
also one internal switch, I guess.

static const struct ntb_dev_data dev_data[] = {
	{ /* for device 145b */
		.mw_count = 3,
		.mw_idx = 1,
		.depth = 2,
	},
	{ /* for device 148b */
		.mw_count = 2,
		.mw_idx = 2,
		.depth = 2,/*maybe is 2, according to implementation of the 148b */
	},
};

static const struct pci_device_id amd_ntb_pci_tbl[] = {
	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
	{ 0, }
};

Thanks,
Jiasen Lin
>>
>> Thanks,
>> Sanjay Mehta
>>> struct pci_dev *pci_up = NULL;
>>> struct pci_dev *pci_dp = NULL;
>>>
>>> if (ndev->ntb.topo == NTB_TOPO_SEC) {
>>>      /* Locate the pointer to Secondary up for this device */
>>>      pci_dp = pci_upstream_bridge(ndev->ntb.pdev);
>>>      /* Read the PCIe Link Control and Status register */
>>>      if (pci_dp) {
>>>         pci_up = pci_upstream_bridge(pci_dp);
>>>         if (pci_up) {
>>>                 rc = pcie_capability_read_dword(pci_up, PCI_EXP_LNKCTL,
>>>                          &stat);
>>>                 if (rc)
>>>                         return 0;
>>>                 }
>>>         }
>>> }
>>>
>>> Thanks,
>>> Jiansen Lin
>>>
>>>> I have modified the code according to your suggestion and tested it
>>>> on Dhyana platform, it works well, expect to receice your patch.
>>>>
>>>> Before modify the code, read the Link Status and control register of the
>>>> secondary NTB device to get link status.
>>>>
>>>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>>>> NTB Device Information:
>>>> Connection Topology -   NTB_TOPO_SEC
>>>> LNK STA -               0x11030042
>>>> Link Status -           Up
>>>> Link Speed -            PCI-E Gen 3
>>>> Link Width -            x16
>>>>
>>>> After modify the code, read the Link Status and control register of the
>>>> secondary RP to get link status.
>>>>
>>>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>>>> NTB Device Information:
>>>> Connection Topology -   NTB_TOPO_SEC
>>>> LNK STA -               0x70830042
>>>> Link Status -           Up
>>>> Link Speed -            PCI-E Gen 3
>>>> Link Width -            x8
>>>>
>>>> Thanks,
>>>> Jiasen Lin
>>>>
>>>>> ---
>>>>>    drivers/ntb/hw/amd/ntb_hw_amd.c | 27
>> +++++++++++++++++++++++----
>>>>>    drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
>>>>>    2 files changed, 23 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>> index 14ad69c..91e1966 100644
>>>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>> @@ -842,6 +842,8 @@ static inline void ndev_init_struct(struct
>>>>> amd_ntb_dev *ndev,
>>>>>    static int amd_poll_link(struct amd_ntb_dev *ndev)
>>>>>    {
>>>>>        void __iomem *mmio = ndev->peer_mmio;
>>>>> +    struct pci_dev *pci_rp = NULL;
>>>>> +    struct pci_dev *pdev = NULL;
>>>>>        u32 reg, stat;
>>>>>        int rc;
>>>>> @@ -855,10 +857,27 @@ static int amd_poll_link(struct amd_ntb_dev
>> *ndev)
>>>>>        ndev->cntl_sta = reg;
>>>>> -    rc = pci_read_config_dword(ndev->ntb.pdev,
>>>>> -                   AMD_LINK_STATUS_OFFSET, &stat);
>>>>> -    if (rc)
>>>>> -        return 0;
>>>>> +    if (ndev->ntb.topo == NTB_TOPO_SEC) {
>>>>> +        /* Locate the pointer to PCIe Root Port for this device */
>>>>> +        pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev);
>>>>> +        /* Read the PCIe Link Control and Status register */
>>>>> +        if (pci_rp) {
>>>>> +            rc = pcie_capability_read_dword(pci_rp, PCI_EXP_LNKCTL,
>>>>> +                            &stat);
>>>>> +            if (rc)
>>>>> +                return 0;
>>>>> +        }
>>>>> +    } else if (ndev->ntb.topo == NTB_TOPO_PRI) {
>>>>> +        /*
>>>>> +         * For NTB primary, we simply read the Link Status and control
>>>>> +         * register of the NTB device itself.
>>>>> +         */
>>>>> +        pdev = ndev->ntb.pdev;
>>>>> +        rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
>>>>> +        if (rc)
>>>>> +            return 0;
>>>>> +    }
>>>>> +
>>>>>        ndev->lnk_sta = stat;
>>>>>        return 1;
>>>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>>>> b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>>>> index 139a307..39e5d18 100644
>>>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>>>> @@ -53,7 +53,6 @@
>>>>>    #include <linux/pci.h>
>>>>>    #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>>>>> -#define AMD_LINK_STATUS_OFFSET    0x68
>>>>>    #define NTB_LIN_STA_ACTIVE_BIT    0x00000002
>>>>>    #define NTB_LNK_STA_SPEED_MASK    0x000F0000
>>>>>    #define NTB_LNK_STA_WIDTH_MASK    0x03F00000
>>>>>
