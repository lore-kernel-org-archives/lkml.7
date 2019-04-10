Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630282084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfDJHO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfDJHO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:14:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB876ADDB;
        Wed, 10 Apr 2019 07:14:56 +0000 (UTC)
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
 <8b1f4912-4f92-69ae-ae01-d899d5640572@oracle.com>
 <3ee91f33-2973-c2db-386f-afbf138081b4@redhat.com>
 <59676804-786d-3df8-7752-8e45dec6d65b@oracle.com>
 <ac0fb2d0-59bf-1330-24ab-331c1a69b13f@suse.com>
 <94738323-ebdf-d58e-55b6-313e27c923b0@oracle.com>
 <585163c2-8dea-728d-7556-9cb3559f0eca@suse.com>
 <97808492-58ee-337f-c894-900b34b7b1a5@oracle.com>
 <59deb041-2b5d-8451-32c7-644fe36e053b@suse.com>
 <8e2e1d56-3490-365c-e2de-c3fd262518ba@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c488152c-b97f-c6ce-1f4e-72aff05d29dd@suse.com>
Date:   Wed, 10 Apr 2019 09:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8e2e1d56-3490-365c-e2de-c3fd262518ba@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 08:55, Ankur Arora wrote:
> On 2019-04-08 10:04 p.m., Juergen Gross wrote:
>> On 08/04/2019 19:31, Joao Martins wrote:
>>> On 4/8/19 11:42 AM, Juergen Gross wrote:
>>>> On 08/04/2019 12:36, Joao Martins wrote:
>>>>> On 4/8/19 7:44 AM, Juergen Gross wrote:
>>>>>> On 12/03/2019 18:14, Joao Martins wrote:
>>>>>>> On 2/22/19 4:59 PM, Paolo Bonzini wrote:
>>>>>>>> On 21/02/19 12:45, Joao Martins wrote:
>>>>>>>>> On 2/20/19 9:09 PM, Paolo Bonzini wrote:
>>>>>>>>>> On 20/02/19 21:15, Joao Martins wrote:
>>>>>>>>>>>   2. PV Driver support (patches 17 - 39)
>>>>>>>>>>>
>>>>>>>>>>>   We start by redirecting hypercalls from the backend to
>>>>>>>>>>> routines
>>>>>>>>>>>   which emulate the behaviour that PV backends expect i.e. grant
>>>>>>>>>>>   table and interdomain events. Next, we add support for late
>>>>>>>>>>>   initialization of xenbus, followed by implementing
>>>>>>>>>>>   frontend/backend communication mechanisms (i.e. grant
>>>>>>>>>>> tables and
>>>>>>>>>>>   interdomain event channels). Finally, introduce xen-shim.ko,
>>>>>>>>>>>   which will setup a limited Xen environment. This uses the
>>>>>>>>>>> added
>>>>>>>>>>>   functionality of Xen specific shared memory (grant tables) and
>>>>>>>>>>>   notifications (event channels).
>>>>>>>>>>
>>>>>>>>>> I am a bit worried by the last patches, they seem really
>>>>>>>>>> brittle and
>>>>>>>>>> prone to breakage.  I don't know Xen well enough to understand
>>>>>>>>>> if the
>>>>>>>>>> lack of support for GNTMAP_host_map is fixable, but if not,
>>>>>>>>>> you have to
>>>>>>>>>> define a completely different hypercall.
>>>>>>>>>>
>>>>>>>>> I guess Ankur already answered this; so just to stack this on
>>>>>>>>> top of his comment.
>>>>>>>>>
>>>>>>>>> The xen_shim_domain() is only meant to handle the case where
>>>>>>>>> the backend
>>>>>>>>> has/can-have full access to guest memory [i.e. netback and
>>>>>>>>> blkback would work
>>>>>>>>> with similar assumptions as vhost?]. For the normal case, where
>>>>>>>>> a backend *in a
>>>>>>>>> guest* maps and unmaps other guest memory, this is not
>>>>>>>>> applicable and these
>>>>>>>>> changes don't affect that case.
>>>>>>>>>
>>>>>>>>> IOW, the PV backend here sits on the hypervisor, and the
>>>>>>>>> hypercalls aren't
>>>>>>>>> actual hypercalls but rather invoking shim_hypercall(). The
>>>>>>>>> call chain would go
>>>>>>>>> more or less like:
>>>>>>>>>
>>>>>>>>> <netback|blkback|scsiback>
>>>>>>>>>   gnttab_map_refs(map_ops, pages)
>>>>>>>>>     HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
>>>>>>>>>       shim_hypercall()
>>>>>>>>>         shim_hcall_gntmap()
>>>>>>>>>
>>>>>>>>> Our reasoning was that given we are already in KVM, why mapping
>>>>>>>>> a page if the
>>>>>>>>> user (i.e. the kernel PV backend) is himself? The lack of
>>>>>>>>> GNTMAP_host_map is how
>>>>>>>>> the shim determines its user doesn't want to map the page.
>>>>>>>>> Also, there's another
>>>>>>>>> issue where PV backends always need a struct page to reference
>>>>>>>>> the device
>>>>>>>>> inflight data as Ankur pointed out.
>>>>>>>>
>>>>>>>> Ultimately it's up to the Xen people.  It does make their API
>>>>>>>> uglier,
>>>>>>>> especially the in/out change for the parameter.  If you can at
>>>>>>>> least
>>>>>>>> avoid that, it would alleviate my concerns quite a bit.
>>>>>>>
>>>>>>> In my view, we have two options overall:
>>>>>>>
>>>>>>> 1) Make it explicit, the changes the PV drivers we have to make in
>>>>>>> order to support xen_shim_domain(). This could mean e.g. a) add a
>>>>>>> callback
>>>>>>> argument to gnttab_map_refs() that is invoked for every page that
>>>>>>> gets looked up
>>>>>>> successfully, and inside this callback the PV driver may update
>>>>>>> it's tracking
>>>>>>> page. Here we no longer have this in/out parameter in
>>>>>>> gnttab_map_refs, and all
>>>>>>> shim_domain specific bits would be a little more abstracted from
>>>>>>> Xen PV
>>>>>>> backends. See netback example below the scissors mark. Or b) have
>>>>>>> sort of a
>>>>>>> translate_gref() and put_gref() API that Xen PV drivers use which
>>>>>>> make it even
>>>>>>> more explicit that there's no grant ops involved. The latter is
>>>>>>> more invasive.
>>>>>>>
>>>>>>> 2) The second option is to support guest grant mapping/unmapping
>>>>>>> [*] to allow
>>>>>>> hosting PV backends inside the guest. This would remove the Xen
>>>>>>> changes in this
>>>>>>> series completely. But it would require another guest being used
>>>>>>> as netback/blkback/xenstored, and less performance than 1)
>>>>>>> (though, in theory,
>>>>>>> it would be equivalent to what does Xen with grants/events). The
>>>>>>> only changes in
>>>>>>> Linux Xen code is adding xenstored domain support, but that is
>>>>>>> useful on its own
>>>>>>> outside the scope of this work.
>>>>>>>
>>>>>>> I think there's value on both; 1) is probably more familiar for
>>>>>>> KVM users
>>>>>>> perhaps (as it is similar to what vhost does?) while  2) equates
>>>>>>> to implementing
>>>>>>> Xen disagregation capabilities in KVM.
>>>>>>>
>>>>>>> Thoughts? Xen maintainers what's your take on this?
>>>>>>
>>>>>> What I'd like best would be a new handle (e.g. xenhost_t *) used
>>>>>> as an
>>>>>> abstraction layer for this kind of stuff. It should be passed to the
>>>>>> backends and those would pass it on to low-level Xen drivers (xenbus,
>>>>>> event channels, grant table, ...).
>>>>>>
>>>>> So if IIRC backends would use the xenhost layer to access grants or
>>>>> frames
>>>>> referenced by grants, and that would grok into some of this. IOW,
>>>>> you would have
>>>>> two implementors of xenhost: one for nested remote/local
>>>>> events+grants and
>>>>> another for this "shim domain" ?
>>>>
>>>> As I'd need that for nested Xen I guess that would make it 3 variants.
>>>> Probably the xen-shim variant would need more hooks, but that should be
>>>> no problem.
>>>>
>>> I probably messed up in the short description but "nested remote/local
>>> events+grants" was referring to nested Xen (FWIW remote meant L0 and
>>> local L1).
>>> So maybe only 2 variants are needed?
>>
>> I need one xenhost variant for the "normal" case as today: talking to
>> the single hypervisor (or in nested case: to the L1 hypervisor).
>>
>> Then I need a variant for the nested case talking to L0 hypervisor.
>>
>> And you need a variant talking to xen-shim.
>>
>> The first two variants can be active in the same system in case of
>> nested Xen: the backends of L2 dom0 are talking to L1 hypervisor,
>> while its frontends are talking with L0 hypervisor.
> Thanks this is clarifying.
> 
> So, essentially backend drivers with a xenhost_t handle, communicate
> with Xen low-level drivers etc using the same handle, however, if they
> communicate with frontend drivers for accessing the "real" world,
> they exclusively use standard mechanisms (Linux or hypercalls)?

This should be opaque to the backends. The xenhost_t handle should have
a pointer to a function vector for relevant grant-, event- and Xenstore-
related functions. Calls to such functions should be done via an inline
function with the xenhost_t handle being one parameter, that function
will then call the correct implementation.

> In this scenario L2 dom0 xen-netback and L2 dom0 xen-netfront should
> just be able to use Linux interfaces. But if L2 dom0 xenbus-backend
> needs to talk to L2 dom0 xenbus-frontend then do you see them layered
> or are they still exclusively talking via the standard mechanisms?

The distinction is made via the function vector in xenhost_t. So the
only change in backends needed is the introduction of xenhost_t.

Whether we want to introduce xenhost_t in frontends, too, is TBD.


Juergen
