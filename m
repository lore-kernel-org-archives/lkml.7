Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B5C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050020872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UDAQv/GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfFFSuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:50:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13057 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfFFSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:50:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf960590000>; Thu, 06 Jun 2019 11:50:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 11:50:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 11:50:15 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 18:50:15 +0000
Subject: Re: [PATCH 1/5] mm/hmm: Update HMM documentation
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-2-rcampbell@nvidia.com>
 <20190606140239.GA21778@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <e1fad454-ac9b-4069-1bc8-8149c72655ca@nvidia.com>
Date:   Thu, 6 Jun 2019 11:50:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606140239.GA21778@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559847001; bh=lnWmoYy7kAn4bLm7t9cFbOMXhWsLoa4EfFFlm+lwmig=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UDAQv/GI8zoEqSn7mrswFwJ98G2U/yQQD/Aj0+YO7Qf5+Xr8LIE45i/9Kf0DT9xG3
         JPPWSe0ZAVdjMHx+2C0ISnDMM3NkNkQqa5NXSEs50jcCB4GiVbS7uUaIN4pcELz3g+
         MfSt7NTboICB1mkUbEx3mzD15NkILVLfyY7W7hCxGsr/Vew7TUf7Kead9IDlmuVFZ6
         0g3htFBOh79b75YZGU+BAEjA89isoq7X+Uy0Kb8zWa5u3BVH/ZZ7h3FAU9N5uKCy4N
         M3lK8+o+d2kh73ZkQKQwz0Fm+222atCS0/SR5UcSUSCqkOPa9W54dbdognW0U2lnZN
         46ZaurvMxolKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/19 7:02 AM, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 04:29:38PM -0700, rcampbell@nvidia.com wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> Update the HMM documentation to reflect the latest API and make a few mi=
nor
>> wording changes.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>   Documentation/vm/hmm.rst | 139 ++++++++++++++++++++-------------------
>>   1 file changed, 73 insertions(+), 66 deletions(-)
>=20
> Okay, lets start picking up hmm patches in to the new shared hmm.git,
> as promised I will take responsibility to send these to Linus. The
> tree is here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=3Dhm=
m
>=20
> This looks fine to me with one minor comment:
>=20
>> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
>> index ec1efa32af3c..7c1e929931a0 100644
>> +++ b/Documentation/vm/hmm.rst
>>  =20
>> @@ -151,21 +151,27 @@ registration of an hmm_mirror struct::
>>  =20
>>    int hmm_mirror_register(struct hmm_mirror *mirror,
>>                            struct mm_struct *mm);
>> - int hmm_mirror_register_locked(struct hmm_mirror *mirror,
>> -                                struct mm_struct *mm);
>>  =20
>> -
>> -The locked variant is to be used when the driver is already holding mma=
p_sem
>> -of the mm in write mode. The mirror struct has a set of callbacks that =
are used
>> +The mirror struct has a set of callbacks that are used
>>   to propagate CPU page tables::
>>  =20
>>    struct hmm_mirror_ops {
>> +     /* release() - release hmm_mirror
>> +      *
>> +      * @mirror: pointer to struct hmm_mirror
>> +      *
>> +      * This is called when the mm_struct is being released.
>> +      * The callback should make sure no references to the mirror occur
>> +      * after the callback returns.
>> +      */
>=20
> This is not quite accurate (at least, as the other series I sent
> intends), the struct hmm_mirror is valid up until
> hmm_mirror_unregister() is called - specifically it remains valid
> after the release() callback.
>=20
> I will revise it (and the hmm.h comment it came from) to read the
> below. Please let me know if you'd like something else:
>=20
> 	/* release() - release hmm_mirror
> 	 *
> 	 * @mirror: pointer to struct hmm_mirror
> 	 *
> 	 * This is called when the mm_struct is being released.  The callback
> 	 * must ensure that all access to any pages obtained from this mirror
> 	 * is halted before the callback returns. All future access should
> 	 * fault.
> 	 */
>=20
> The key task for release is to fence off all device access to any
> related pages as the mm is about to recycle them and the device must
> not cause a use-after-free.
>=20
> I applied it to hmm.git
>=20
> Thanks,
> Jason
>=20

Yes, I agree this is better.

Also, I noticed the sample code for hmm_range_register() is wrong.
If you could merge this minor change into this patch, that
would be appreciated.

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index dc8fe4241a18..b5fb9bc02aa2 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -245,7 +245,7 @@ The usage pattern is::
              hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
              goto again;
            }
-          hmm_mirror_unregister(&range);
+          hmm_range_unregister(&range);
            return ret;
        }
        take_lock(driver->update);
@@ -257,7 +257,7 @@ The usage pattern is::

        // Use pfns array content to update device page table

-      hmm_mirror_unregister(&range);
+      hmm_range_unregister(&range);
        release_lock(driver->update);
        up_read(&mm->mmap_sem);
        return 0;
