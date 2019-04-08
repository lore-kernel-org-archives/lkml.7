Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9798C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C0D208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDHKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:43:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfDHKnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:43:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBAA5B617;
        Mon,  8 Apr 2019 10:43:00 +0000 (UTC)
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 mQENBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAG0H0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT6JATkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPuQENBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAGJAR8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHf4kBrQQY
 AQgAIBYhBIUSZ3Lo9gSUpdCX97DendYovxMvBQJa3fDQAhsCAIEJELDendYovxMvdiAEGRYI
 AB0WIQRTLbB6QfY48x44uB6AXGG7T9hjvgUCWt3w0AAKCRCAXGG7T9hjvk2LAP99B/9FenK/
 1lfifxQmsoOrjbZtzCS6OKxPqOLHaY47BgEAqKKn36YAPpbk09d2GTVetoQJwiylx/Z9/mQI
 CUbQMg1pNQf9EjA1bNcMbnzJCgt0P9Q9wWCLwZa01SnQWFz8Z4HEaKldie+5bHBL5CzVBrLv
 81tqX+/j95llpazzCXZW2sdNL3r8gXqrajSox7LR2rYDGdltAhQuISd2BHrbkQVEWD4hs7iV
 1KQHe2uwXbKlguKPhk5ubZxqwsg/uIHw0qZDk+d0vxjTtO2JD5Jv/CeDgaBX4Emgp0NYs8IC
 UIyKXBtnzwiNv4cX9qKlz2Gyq9b+GdcLYZqMlIBjdCz0yJvgeb3WPNsCOanvbjelDhskx9gd
 6YUUFFqgsLtrKpCNyy203a58g2WosU9k9H+LcheS37Ph2vMVTISMszW9W8gyORSgmw==
Message-ID: <585163c2-8dea-728d-7556-9cb3559f0eca@suse.com>
Date:   Mon, 8 Apr 2019 12:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <94738323-ebdf-d58e-55b6-313e27c923b0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 12:36, Joao Martins wrote:
> On 4/8/19 7:44 AM, Juergen Gross wrote:
>> On 12/03/2019 18:14, Joao Martins wrote:
>>> On 2/22/19 4:59 PM, Paolo Bonzini wrote:
>>>> On 21/02/19 12:45, Joao Martins wrote:
>>>>> On 2/20/19 9:09 PM, Paolo Bonzini wrote:
>>>>>> On 20/02/19 21:15, Joao Martins wrote:
>>>>>>>  2. PV Driver support (patches 17 - 39)
>>>>>>>
>>>>>>>  We start by redirecting hypercalls from the backend to routines
>>>>>>>  which emulate the behaviour that PV backends expect i.e. grant
>>>>>>>  table and interdomain events. Next, we add support for late
>>>>>>>  initialization of xenbus, followed by implementing
>>>>>>>  frontend/backend communication mechanisms (i.e. grant tables and
>>>>>>>  interdomain event channels). Finally, introduce xen-shim.ko,
>>>>>>>  which will setup a limited Xen environment. This uses the added
>>>>>>>  functionality of Xen specific shared memory (grant tables) and
>>>>>>>  notifications (event channels).
>>>>>>
>>>>>> I am a bit worried by the last patches, they seem really brittle and
>>>>>> prone to breakage.  I don't know Xen well enough to understand if the
>>>>>> lack of support for GNTMAP_host_map is fixable, but if not, you have to
>>>>>> define a completely different hypercall.
>>>>>>
>>>>> I guess Ankur already answered this; so just to stack this on top of his comment.
>>>>>
>>>>> The xen_shim_domain() is only meant to handle the case where the backend
>>>>> has/can-have full access to guest memory [i.e. netback and blkback would work
>>>>> with similar assumptions as vhost?]. For the normal case, where a backend *in a
>>>>> guest* maps and unmaps other guest memory, this is not applicable and these
>>>>> changes don't affect that case.
>>>>>
>>>>> IOW, the PV backend here sits on the hypervisor, and the hypercalls aren't
>>>>> actual hypercalls but rather invoking shim_hypercall(). The call chain would go
>>>>> more or less like:
>>>>>
>>>>> <netback|blkback|scsiback>
>>>>>  gnttab_map_refs(map_ops, pages)
>>>>>    HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
>>>>>      shim_hypercall()
>>>>>        shim_hcall_gntmap()
>>>>>
>>>>> Our reasoning was that given we are already in KVM, why mapping a page if the
>>>>> user (i.e. the kernel PV backend) is himself? The lack of GNTMAP_host_map is how
>>>>> the shim determines its user doesn't want to map the page. Also, there's another
>>>>> issue where PV backends always need a struct page to reference the device
>>>>> inflight data as Ankur pointed out.
>>>>
>>>> Ultimately it's up to the Xen people.  It does make their API uglier,
>>>> especially the in/out change for the parameter.  If you can at least
>>>> avoid that, it would alleviate my concerns quite a bit.
>>>
>>> In my view, we have two options overall:
>>>
>>> 1) Make it explicit, the changes the PV drivers we have to make in
>>> order to support xen_shim_domain(). This could mean e.g. a) add a callback
>>> argument to gnttab_map_refs() that is invoked for every page that gets looked up
>>> successfully, and inside this callback the PV driver may update it's tracking
>>> page. Here we no longer have this in/out parameter in gnttab_map_refs, and all
>>> shim_domain specific bits would be a little more abstracted from Xen PV
>>> backends. See netback example below the scissors mark. Or b) have sort of a
>>> translate_gref() and put_gref() API that Xen PV drivers use which make it even
>>> more explicit that there's no grant ops involved. The latter is more invasive.
>>>
>>> 2) The second option is to support guest grant mapping/unmapping [*] to allow
>>> hosting PV backends inside the guest. This would remove the Xen changes in this
>>> series completely. But it would require another guest being used
>>> as netback/blkback/xenstored, and less performance than 1) (though, in theory,
>>> it would be equivalent to what does Xen with grants/events). The only changes in
>>> Linux Xen code is adding xenstored domain support, but that is useful on its own
>>> outside the scope of this work.
>>>
>>> I think there's value on both; 1) is probably more familiar for KVM users
>>> perhaps (as it is similar to what vhost does?) while  2) equates to implementing
>>> Xen disagregation capabilities in KVM.
>>>
>>> Thoughts? Xen maintainers what's your take on this?
>>
>> What I'd like best would be a new handle (e.g. xenhost_t *) used as an
>> abstraction layer for this kind of stuff. It should be passed to the
>> backends and those would pass it on to low-level Xen drivers (xenbus,
>> event channels, grant table, ...).
>>
> So if IIRC backends would use the xenhost layer to access grants or frames
> referenced by grants, and that would grok into some of this. IOW, you would have
> two implementors of xenhost: one for nested remote/local events+grants and
> another for this "shim domain" ?

As I'd need that for nested Xen I guess that would make it 3 variants.
Probably the xen-shim variant would need more hooks, but that should be
no problem.

>> I was planning to do that (the xenhost_t * stuff) soon in order to add
>> support for nested Xen using PV devices (you need two Xenstores for that
>> as the nested dom0 is acting as Xen backend server, while using PV
>> frontends for accessing the "real" world outside).
>>
>> The xenhost_t should be used for:
>>
>> - accessing Xenstore
>> - issuing and receiving events
>> - doing hypercalls
>> - grant table operations
>>
> 
> In the text above, I sort of suggested a slice of this on 1.b) with a
> translate_gref() and put_gref() API -- to get the page from a gref. This was
> because of the flags|host_addr hurdle we depicted above wrt to using using grant
> maps/unmaps. You think some of the xenhost layer would be ammenable to support
> this case?

I think so, yes.

> 
>> So exactly the kind of stuff you want to do, too.
>>
> Cool idea!

In the end you might make my life easier for nested Xen. :-)

Do you want to have a try with that idea or should I do that? I might be
able to start working on that in about a month.


Juergen
