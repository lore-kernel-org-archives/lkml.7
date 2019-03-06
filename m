Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65402C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321DA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfCFUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbfCFUbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:31:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 425E130A81BE;
        Wed,  6 Mar 2019 20:31:31 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C65A5C647;
        Wed,  6 Mar 2019 20:31:20 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
 <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com>
 <CAKgT0UdqCb37VNe7pABBYBXYFrVzYdPntmPf-V6ZYp9DdwmxYA@mail.gmail.com>
 <7b98b7b3-68f5-e4e0-1454-2217f41e46ad@redhat.com>
 <CAKgT0UePn86cnjzietzuqdosjJH3McH2xDQ3ocjbujMKdsk7Pw@mail.gmail.com>
Organization: Red Hat Inc,
Message-ID: <7f82319b-17a8-71f9-853e-fccbe064282c@redhat.com>
Date:   Wed, 6 Mar 2019 15:31:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UePn86cnjzietzuqdosjJH3McH2xDQ3ocjbujMKdsk7Pw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xOcfvAQELRTUWgL4ByVin4A4MMsspyN5F"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 06 Mar 2019 20:31:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOcfvAQELRTUWgL4ByVin4A4MMsspyN5F
Content-Type: multipart/mixed; boundary="TZLb9yKarVLPas4urIf5edq6PNwntwBBE";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
 David Hildenbrand <david@redhat.com>
Message-ID: <7f82319b-17a8-71f9-853e-fccbe064282c@redhat.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting

--TZLb9yKarVLPas4urIf5edq6PNwntwBBE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 2:24 PM, Alexander Duyck wrote:
> On Wed, Mar 6, 2019 at 11:18 AM David Hildenbrand <david@redhat.com> wr=
ote:
>> On 06.03.19 20:08, Alexander Duyck wrote:
>>> On Wed, Mar 6, 2019 at 11:00 AM David Hildenbrand <david@redhat.com> =
wrote:
>>>> On 06.03.19 19:43, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:=

>>>>>>>> Here are the results:
>>>>>>>>
>>>>>>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA nod=
e with
>>>>>>>> total memory of 15GB and no swap. In each of the guest, memhog i=
s run
>>>>>>>> with 5GB. Post-execution of memhog, Host memory usage is monitor=
ed by
>>>>>>>> using Free command.
>>>>>>>>
>>>>>>>> Without Hinting:
>>>>>>>>                  Time of execution    Host used memory
>>>>>>>> Guest 1:        45 seconds            5.4 GB
>>>>>>>> Guest 2:        45 seconds            10 GB
>>>>>>>> Guest 3:        1  minute               15 GB
>>>>>>>>
>>>>>>>> With Hinting:
>>>>>>>>                 Time of execution     Host used memory
>>>>>>>> Guest 1:        49 seconds            2.4 GB
>>>>>>>> Guest 2:        40 seconds            4.3 GB
>>>>>>>> Guest 3:        50 seconds            6.3 GB
>>>>>>> OK so no improvement.
>>>>>> If we are looking in terms of memory we are getting back from the =
guest,
>>>>>> then there is an improvement. However, if we are looking at the
>>>>>> improvement in terms of time of execution of memhog then yes there=
 is none.
>>>>> Yes but the way I see it you can't overcommit this unused memory
>>>>> since guests can start using it at any time.  You timed it carefull=
y
>>>>> such that this does not happen, but what will cause this timing on =
real
>>>>> guests?
>>>> Whenever you overcommit you will need backup swap. There is no way
>>>> around it. It just makes the probability of you having to go to disk=

>>>> less likely.
>>>>
>>>> If you assume that all of your guests will be using all of their mem=
ory
>>>> all the time, you don't have to think about overcommiting memory in =
the
>>>> first place. But this is not what we usually have.
>>> Right, but the general idea is that free page hinting allows us to
>>> avoid having to use the swap if we are hinting the pages as unused.
>>> The general assumption we are working with is that some percentage of=

>>> the VMs are unused most of the time so you can share those resources
>>> between multiple VMs and have them free those up normally.
>> Yes, similar to VCPU yielding or playin scheduling when the VCPU is
>> spleeping. Instead of busy looping, hand over the resource to somebody=

>> who can actually make use of it.
>>
>>> If we can reduce swap usage we can improve overall performance and
>>> that was what I was pointing out with my test. I had also done
>>> something similar to what Nitesh was doing with his original test
>>> where I had launched 8 VMs with 8GB of memory per VM on a system with=

>>> 32G of RAM and only 4G of swap. In that setup I could keep a couple
>>> VMs busy at a time without issues, and obviously without the patch I
>>> just started to OOM qemu instances and  could only have 4 VMs at a
>>> time running at maximum.
>> While these are nice experiments (especially to showcase reduced swap
>> usage!), I would not suggest to use 4GB of swap on a x2 overcomited
>> system (32GB overcommited). Disks are so cheap nowadays that one does
>> not have to play with fire.
> Right. The only reason for using 4G is because the system normally has
> 128G of RAM available and I didn't really think I would need swap for
> the system when I originally configured it.
>
>> But yes, reducing swap usage implies overall system performance (unles=
s
>> the hinting is terribly slow :) ). Reducing swap usage, not swap space=
 :)
> Right. Also the swap is really a necessity if we are going to look at
> things like MADV_FREE as I have not seen us really start to free up
> resources until we are starting to put some pressure on swap.
I agree in order to see the effect of MADV_FREE we may have to use
swap(it doesn't have to be huge).
About Michael's comment, if the guest is consistently under memory
pressure then we may not get anything back in the host at all during
this time.


--=20
Thanks
Nitesh


--TZLb9yKarVLPas4urIf5edq6PNwntwBBE--

--xOcfvAQELRTUWgL4ByVin4A4MMsspyN5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlyALhYACgkQo4ZA3AYy
ozlDYw/9F8NvkshmvVPAJtd0pZqaaFw9gpymX81vRnXnGdFI+jXt5h215P6hXO6+
FQKlWJu3gV4NPefa/hOYcLe++/b+eARdRUQIluxlwoEDkMbxAFKHAXi0s5aDhKR2
3gWukHuEKXm/V8xyqrh34By10Dl83JPtFAw0WOfAUadMmTPEmAIWreky3KUs9s4j
3LS+YbXUT7LVwzFOgh9ScYn6MhkS9Ais6Di4cPcBc962WhDlfFhYbR3YFFpOXcgb
NPZfXp649nnJjMumH0SnohUXEiZmuVn9f8HjZIUu8Jckn2j3TceXX4MnZzrVYHt4
gfo3JRydjB+y/2NUdjOqcDZrHRZILMEr+GZyoIvqd3nG/7mku+yf85UoVwgcAHQv
AsKHZhjHDp2HTnV8wBFgO7amvCF29jpvdFpIZjkpQeejHfT0x4sFg0rDKc5Z6F57
gkJotUkvvBegUJHh86/5Yk525lNdywEd4pFPBDVoLl71s1eHhVwfyNbUr/QhSW5e
7IzDxRboTxgI0k1cBQjuXBFN1Etqa2prkou171DmBhnKJSmKEe1tum3aYaTV+YOR
0vOKzIJgoAK640bqO9kIxaO8kD5DUnIReRj5I9gNmjmEfYXjmIRyodoHpYE5bl7h
GUMTkt3Rci/72UmqmHrAfLvZv41MMLyArJV5EdWqgxZJAniJXxE=
=Fdc3
-----END PGP SIGNATURE-----

--xOcfvAQELRTUWgL4ByVin4A4MMsspyN5F--
