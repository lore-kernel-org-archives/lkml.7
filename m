Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA938C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A28F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UiF/N5tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLSSed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:34:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:34:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJIR9Ik046131;
        Thu, 19 Dec 2019 18:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=612PohDcN+LPYumX+nTCZyXRMRyst9GqwLbWBrVVPXA=;
 b=UiF/N5tIgThnT0MhlVg4bwDWoTSMT/gZY2EpLJpvUY8evcpXoFfyMP+e/JSc1o9G8GjW
 kSxT0RBwi7yZUwkmuhDs8nOwi46uV3F6LOVKseCXDQNjM0mRANH/9GXxHkxPrbmeNEIN
 JiD8IfZggBiK4t1a2Ft+5XKxlEsJmMo4fkMvtAHVbehaXuYkLT5slT2LTQ/f5qaEul0t
 augila4KZ7McfY1wDzV9tjbb+T97vWJ54gkSAzrkZCVtkBLgAmH7mqqCra4VAjRbRd7/
 pT+SpNRctKAMW9CaMS+2mgT3Fb4WXyCibYL9A7W9/lpYjvsnV7sOQryaUGNLDFJjqdLk Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x01knmmrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 18:34:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEJtM035040;
        Thu, 19 Dec 2019 18:34:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wyxqj3t1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 18:34:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJIXuM9030907;
        Thu, 19 Dec 2019 18:33:56 GMT
Received: from dhcp-10-154-178-61.vpn.oracle.com (/10.154.178.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 10:33:55 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: `
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <94c4540b-6467-002f-6cfc-bacc4ac45d24@huawei.com>
Date:   Thu, 19 Dec 2019 12:33:51 -0600
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, dyoung@redhat.com,
        bhsharma@redhat.com, horms@verge.net.au, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA397BBF-56F6-4E8A-964D-ACB78F1DD9B4@oracle.com>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
 <11E080AF-28F1-481A-BF16-9C062091D900@oracle.com>
 <94c4540b-6467-002f-6cfc-bacc4ac45d24@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 18, 2019, at 8:56 PM, Chen Zhou <chenzhou10@huawei.com> wrote:
>=20
> Hi John,
>=20
> On 2019/12/19 1:18, John Donnelly wrote:
>> HI=20
>>=20
>> SEE INLINE ON A QUESTION :
>>=20
>>> On Dec 17, 2019, at 8:07 PM, Chen Zhou <chenzhou10@huawei.com> =
wrote:
>>>=20
>>> Hi all,
>>>=20
>>> Friendly ping...
>>>=20
>>> On 2019/8/30 15:11, Chen Zhou wrote:
>>>> I am busy with other things, so it was a long time before this =
version was
>>>> released.
>>>>=20
>>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>>=20
>>>> There are following issues in arm64 kdump:
>>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which =
will fail
>>>> when there is no enough low memory.
>>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel =
above 4G,
>>>> in this case, if swiotlb or DMA buffers are requierd, crash dump =
kernel
>>>> will boot failure because there is no low memory available for =
allocation.
>>=20
>>=20
>>      Can you elaborate when the boot failures may fail due to lacking =
 swiotlb or DMA buffers ? Are these related to certain adapters or =
specific  platforms  ?=20
>>=20
>>     I have not seen this when using   crashkernel=3D2024M@35GB .=20
>>=20
>=20
> For example, in my environment "Huawei TaiShan 2280",
> we need to use mpt3sas driver in crash dump kernel for dumping vmcore.
>=20
> mpt3sas driver needs to call dma_pool_alloc to allocate some pages,
> if there is no DMA buffer, page allocation will fail, which leads to =
crash dump kernel boot failure,
> like this:
>=20
> [2019/12/19 9:12:41] [   12.403501] mpt3sas_cm0: diag reset: SUCCESS
> [2019/12/19 9:12:41] [   12.456076] mpt3sas_cm0: reply_post_free pool: =
dma_pool_alloc failed
> [2019/12/19 9:12:41] [   12.462515] pci 0004:48:00.0: can't derive =
routing for PCI INT A
> [2019/12/19 9:12:41] [   12.468761] mpt3sas 0004:49:00.0: PCI INT A: =
no GSI
> [2019/12/19 9:12:41] [   12.476348] mpt3sas_cm0: failure at =
drivers/scsi/mpt3sas/mpt3sas_scsih.c:10626/_scsih_probe()!
> [2019/12/19 9:14:38] [ TIME ] Timed out waiting for device =
dev-di=E2=80=A6b3\x2d890a\x2d2ead7df26f48.device.
> [2019/12/19 9:14:38] [DEPEND] Dependency failed for Initrd Root =
Device.
> [2019/12/19 9:14:38] [DEPEND] Dependency failed for /sysroot.
> [2019/12/19 9:14:38] [DEPEND] Dependency failed for Initrd Root File =
System.
> [2019/12/19 9:14:38] [DEPEND] Dependency failed for Reload =
Configuration from the Real Root.
> [2019/12/19 9:14:38] [DEPEND] Dependency failed for File System =
C=E2=80=A640bae-9eb8-46b3-890a-2ead7df26f48.


 Thank you for sharing .  We are not seeing this issue on a 5.4.0.rc8 ;  =
  Like I said in a previous email we can  take crash dumps using =
crashkernel=3D768M for a  =E2=80=9C standard =E2=80=9C small VMcore to =
local storage :

0004:01:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3316 =
[Intruder] (rev 01)
	Subsystem: Broadcom / LSI MegaRAID SAS 9361-16i
	Kernel driver in use: megaraid_sas=20


What version of the kernel are you using ?


>=20
> Thanks,
> Chen Zhou
>=20
>>=20
>>>>=20
>>>> To solve these issues, introduce crashkernel=3DX,low to reserve =
specified
>>>> size low memory.
>>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
>>>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve =
spcified
>>>> size low memory for crash kdump kernel devices firstly and then =
reserve
>>>> memory above 4G.
>>>>=20
>>>> When crashkernel is reserved above 4G in memory, that is, =
crashkernel=3DX,low
>>>> is specified simultaneously, kernel should reserve specified size =
low memory
>>>> for crash dump kernel devices. So there may be two crash kernel =
regions, one
>>>> is below 4G, the other is above 4G.
>>>> In order to distinct from the high region and make no effect to the =
use of
>>>> kexec-tools, rename the low region as "Crash kernel (low)", and add =
DT property
>>>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low =
region.
>>>>=20
>>>> Besides, we need to modify kexec-tools:
>>>> arm64: kdump: add another DT property to crash dump kernel's =
dtb(see [1])
>>>>=20
>>>> The previous changes and discussions can be retrieved from:
>>>>=20
>>>> Changes since [v5]
>>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>>>> - Delete crashkernel=3DX,high.
>>>> - Modify crashkernel=3DX,low.
>>>> If crashkernel=3DX,low is specified simultaneously, reserve =
spcified size low
>>>> memory for crash kdump kernel devices firstly and then reserve =
memory above 4G.
>>>> In addition, rename crashk_low_res as "Crash kernel (low)" for =
arm64, and then
>>>> pass to crash dump kernel by DT property "linux,low-memory-range".
>>>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>>>=20
>>>> Changes since [v4]
>>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by =
Mike.
>>>>=20
>>>> Changes since [v3]
>>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>>> - Fix some compiling warnings.
>>>>=20
>>>> Changes since [v2]
>>>> - Split patch "arm64: kdump: support reserving crashkernel above =
4G" as
>>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a =
separate
>>>> patch.
>>>>=20
>>>> Changes since [v1]:
>>>> - Move common reserve_crashkernel_low() code into =
kernel/kexec_core.c.
>>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement =
that
>>>> in fdt_enforce_memory_region().
>>>> There are at most two crash kernel regions, for two crash kernel =
regions
>>>> case, we cap the memory range [min(regs[*].start), =
max(regs[*].end)]
>>>> and then remove the memory range in the middle.
>>>>=20
>>>> [1]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_=
pipermail_kexec_2019-2DAugust_023569.html&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZ=
YR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc=
&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWzGWSphuvXXlXow68&s=3D9tn9kUBabiuYhVtXauANS=
DGaISnCnHLYcAUQgsPBFxs&e=3D=20
>>>> [v1]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
4_2_1174&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2=
fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWz=
GWSphuvXXlXow68&s=3DF-lM7II2cuMF_sK3b6-QhSbWM3X-pI_WZEs0sZitS7A&e=3D=20
>>>> [v2]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
4_9_86&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2fP=
g9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWzGW=
SphuvXXlXow68&s=3D5Y-S6sqMTklHkOQsNtjTX3C7pV05BjKLGhJVfMHEvDs&e=3D=20
>>>> [v3]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
4_9_306&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2f=
Pg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWzG=
WSphuvXXlXow68&s=3DcWn4zSRQupaZ3jjz4eDvD-pNkoLyL_hsZoRx4yJoD0c&e=3D=20
>>>> [v4]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
4_15_273&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2=
fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWz=
GWSphuvXXlXow68&s=3DNslk4RJKIyIuT0IoQoolXNjupEDXplPhQQwnTSoXNWE&e=3D=20
>>>> [v5]: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
5_6_1360&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2=
fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3Dvevd09m6neWWz=
GWSphuvXXlXow68&s=3DHJVAM6sCxV2DnNg5d4pw8WPqtkmQnKvztEmkSIgtQ5M&e=3D=20
>>>>=20
>>>> Chen Zhou (4):
>>>> x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>>> arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>>> arm64: kdump: add memory for devices by DT property, =
low-memory-range
>>>> kdump: update Documentation about crashkernel on arm64
>>>>=20
>>>> Documentation/admin-guide/kdump/kdump.rst       | 13 ++++-
>>>> Documentation/admin-guide/kernel-parameters.txt | 12 ++++-
>>>> arch/arm64/include/asm/kexec.h                  |  3 ++
>>>> arch/arm64/kernel/setup.c                       |  8 ++-
>>>> arch/arm64/mm/init.c                            | 61 =
+++++++++++++++++++++--
>>>> arch/x86/include/asm/kexec.h                    |  3 ++
>>>> arch/x86/kernel/setup.c                         | 65 =
+++----------------------
>>>> include/linux/crash_core.h                      |  4 ++
>>>> include/linux/kexec.h                           |  1 -
>>>> kernel/crash_core.c                             | 65 =
+++++++++++++++++++++++++
>>>> 10 files changed, 168 insertions(+), 67 deletions(-)
>>>>=20
>>>=20
>>>=20
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_=
mailman_listinfo_kexec&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65e=
apI_JnE&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DZAC6UYbT-3qLR3=
Dvevd09m6neWWzGWSphuvXXlXow68&s=3DXMcFx61B_QPg-FUfG_-t88DKCnGm4grqu6zRguiH=
YrU&e=3D=20
>>=20
>>=20
>> .

