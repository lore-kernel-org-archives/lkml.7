Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAEAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFA02175B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfCXDBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:01:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727702AbfCXDBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:01:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87C02AD6D;
        Sun, 24 Mar 2019 03:01:11 +0000 (UTC)
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
 <87in8ghetm.fsf@xmission.com> <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com>
 <87y355mvok.fsf@xmission.com>
From:   Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jeffm@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6463651b-3451-482e-9048-8331796a6585@suse.com>
Date:   Sat, 23 Mar 2019 23:01:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87y355mvok.fsf@xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fj1Rlg69NjuwnVP3qc5bqPtjWQgNkiEE1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fj1Rlg69NjuwnVP3qc5bqPtjWQgNkiEE1
Content-Type: multipart/mixed; boundary="h3D118LSHpRJvdIEzTpP3BRpShFV7uEO2";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>
Message-ID: <6463651b-3451-482e-9048-8331796a6585@suse.com>
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
References: <20180424022106.16952-1-jeffm@suse.com>
 <87in8ghetm.fsf@xmission.com> <676ed981-0047-85ee-b5b1-ebde75cfbd74@suse.com>
 <87y355mvok.fsf@xmission.com>
In-Reply-To: <87y355mvok.fsf@xmission.com>

--h3D118LSHpRJvdIEzTpP3BRpShFV7uEO2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/23/19 11:56 AM, Eric W. Biederman wrote:
> Jeff Mahoney <jeffm@suse.com> writes:
>=20
>> On 4/24/18 10:14 AM, Eric W. Biederman wrote:
>>> jeffm@suse.com writes:
>>>
>>>> From: Jeff Mahoney <jeffm@suse.com>
>>>>
>>>> Hi all -
>>>>
>>>> I recently encountered a customer issue where, on a machine with man=
y TiB
>>>> of memory and a few hundred cores, after a task with a few thousand =
threads
>>>> and hundreds of files open exited, the system would softlockup.  Tha=
t
>>>> issue was (is still) being addressed by Nik Borisov's patch to add a=

>>>> cond_resched call to shrink_dentry_list.  The underlying issue is st=
ill
>>>> there, though.  We just don't complain as loudly.  When a huge task
>>>> exits, now the system is more or less unresponsive for about eight
>>>> minutes.  All CPUs are pinned and every one of them is going through=

>>>> dentry and inode eviction for the procfs files associated with each
>>>> thread.  It's made worse by every CPU contending on the super's
>>>> inode list lock.
>>>>
>>>> The numbers get big.  My test case was 4096 threads with 16384 files=

>>>> open.  It's a contrived example, but not that far off from the actua=
l
>>>> customer case.  In this case, a simple "find /proc" would create aro=
und
>>>> 300 million dentry/inode pairs.  More practically, lsof(1) does it t=
oo,
>>>> it just takes longer.  On smaller systems, memory pressure starts pu=
shing
>>>> them out. Memory pressure isn't really an issue on this machine, so =
we
>>>> end up using well over 100GB for proc files.  It's the combination o=
f
>>>> the wasted CPU cycles in teardown and the wasted memory at runtime t=
hat
>>>> pushed me to take this approach.
>>>>
>>>> The biggest culprit is the "fd" and "fdinfo" directories, but those =
are
>>>> made worse by there being multiple copies of them even for the same
>>>> task without threads getting involved:
>>>>
>>>> - /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
>>>>   resources.
>>>>
>>>> - Every /proc/pid/task/*/fd directory in a thread group has identica=
l
>>>>   contents (unless unshare(CLONE_FILES) was called), but share no
>>>>   resources.
>>>>
>>>> - If we do a lookup like /proc/pid/fd on a member of a thread group,=

>>>>   we'll get a valid directory.  Inside, there will be a complete
>>>>   copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
>>>>   nothing is shared.
>>>>
>>>> This patch set reduces some (most) of the duplication by conditional=
ly
>>>> replacing some of the directories with symbolic links to copies that=
 are
>>>> identical.
>>>>
>>>> 1) Eliminate the duplication of the task directories between threads=
=2E
>>>>    The task directory belongs to the thread leader and the threads
>>>>    link to it: e.g. /proc/915/task -> ../910/task  This mainly
>>>>    reduces duplication when individual threads are looked up directl=
y
>>>>    at the tgid level.  The impact varies based on the number of thre=
ads.
>>>>    The user has to go out of their way in order to mess up their sys=
tem
>>>>    in this way.  But if they were so inclined, they could create ~55=
0
>>>>    billion inodes and dentries using the test case.
>>>>
>>>> 2) Eliminate the duplication of directories that are created identic=
ally
>>>>    between the tgid-level pid directory and its task directory: fd,
>>>>    fdinfo, ns, net, attr.  There is obviously more duplication betwe=
en
>>>>    the two directories, but replacing a file with a symbolic link
>>>>    doesn't get us anything.  This reduces the number of files associ=
ated
>>>>    with fd and fdinfo by half if threads aren't involved.
>>>>
>>>> 3) Eliminate the duplication of fd and fdinfo directories among thre=
ads
>>>>    that share a files_struct.  We check at directory creation time i=
f
>>>>    the task is a group leader and if not, whether it shares ->files =
with
>>>>    the group leader.  If so, we create a symbolic link to ../tgid/fd=
*.
>>>>    We use a d_revalidate callback to check whether the thread has ca=
lled
>>>>    unshare(CLONE_FILES) and, if so, fail the revalidation for the sy=
mlink.
>>>>    Upon re-lookup, a directory will be created in its place.  This i=
s
>>>>    pretty simple, so if the thread group leader calls unshare, all t=
hreads
>>>>    get directories.
>>>>
>>>> With these patches applied, running the same testcase, the proc_inod=
e
>>>> cache only gets to about 600k objects, which is about 99.7% fewer.  =
I
>>>> get that procfs isn't supposed to be scalable, but this is kind of
>>>> extreme. :)
>>>>
>>>> Finally, I'm not a procfs expert.  I'm posting this as an RFC for fo=
lks
>>>> with more knowledge of the details to pick it apart.  The biggest is=
 that
>>>> I'm not sure if any tools depend on any of these things being direct=
ories
>>>> instead of symlinks.  I'd hope not, but I don't have the answer.  I'=
m
>>>> sure there are corner cases I'm missing.  Hopefully, it's not just f=
lat
>>>> out broken since this is a problem that does need solving.
>>>>
>>>> Now I'll go put on the fireproof suit.
>>
>> Thanks for your comments.  This ended up having to get back-burnered b=
ut
>> I've finally found some time to get back to it.  I have new patches th=
at
>> don't treat each entry as a special case and makes more sense, IMO.
>> They're not worth posting yet since some of the issues below remain.
>>
>>> This needs to be tested against at least apparmor to see if this brea=
ks
>>> common policies.  Changing files to symlinks in proc has a bad habit =
of
>>> either breaking apparmor policies or userspace assumptions.   Symboli=
c
>>> links are unfortunately visible to userspace.
>>
>> AppArmor uses the @{pids} var in profiles that translates to a numeric=

>> regex.  That means that /proc/pid/task -> /proc/tgid/task won't break
>> profiles but /proc/pid/fdinfo -> /proc/pid/task/tgid/fdinfo will break=
=2E
>>  Apparmor doesn't have a follow_link hook at all, so all that matters =
is
>> the final path.  SELinux does have a follow_link hook, but I'm not
>> familiar enough with it to know whether introducing a symlink in proc
>> will make a difference.
>>
>> I've dropped the /proc/pid/{dirs} -> /proc/pid/task/pid/{dirs} part
>> since that clearly won't work.
>>
>>> Further the proc structure is tgid/task/tid where the leaf directorie=
s
>>> are per thread.
>>
>> Yes, but threads are still in /proc for lookup at the tgid level even =
if
>> they don't show up in readdir.
>>
>>> We more likely could get away with some magic symlinks (that would no=
t
>>> be user visible) rather than actual symlinks.
>>
>> I think I'm missing something here.  Aren't magic symlinks still
>> represented to the user as symlinks?
>>
>>> So I think you are probably on the right track to reduce the memory
>>> usage but I think some more work will be needed to make it transparen=
tly
>>> backwards compatible.
>>
>> Yeah, that's going to be the big hiccup.  I think I've resolved the
>> biggest issue with AppArmor, but I don't think the problem is solvable=

>> without introducing symlinks.
>=20
> Has anyone looked at making the fd and fdinfo files hard links.

That could work to a certain degree.  It would certainly reduce the
inode count.  It would still create all the dentries, though.  That's
still a n^2 problem where n is the number of threads in the group.

> Alternatively it may make sense to see if there is something that we ca=
n
> do with the locking to reduce the thundering hurd problem that is being=

> seen.

Yeah, that could still use some attention.  The thundering herd problem
is more of a tap when you reduce the contention by 99% though.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--h3D118LSHpRJvdIEzTpP3BRpShFV7uEO2--

--Fj1Rlg69NjuwnVP3qc5bqPtjWQgNkiEE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAlyW8vQACgkQHntLYyF5
5bJhsg//cyvBFBE8kdF9+1+o0/l6qKbIOpzWaBy3bW1pL2XUyDzuNi7ixooLSy59
ex3IPXJcEm4DcDMhenEhY67yFlxxQMMYzbFish+TxBys847M1iGfLEyeqfR4vDrB
pGvSsnL5FzNU4ewHFOQKNAQ20ztMnxwrafF6o0diYWTUyiqvuc8TbyYKZ+fjjXHy
+r76+NBFYy6z5A/QukuEQvqb9Nne+yzyS3GAMlNJeEnidfl84+tsUG4tD3pMoz5m
iFoRB7u/nnhHX5sxcLC7tFIXG/a4SkuUn/wKqQoaTctQBMYOdWUjnSyqW3pdfeva
uFhLKvTmjamnhw+fJ0P74+XuMNtmHZLBxOEKO6VIqt+cCV0AxbIX+aCSVgDQjD+r
NXfQKkEd4yblZ6aLtOIMmf/m2bQSuraQW3XMRWlBnQqIyXiktfDDhOnXRMwupPWh
F7H1V89fMyDb+13I0M9EPFE5ci1nbl3Ayi2M1Bfas3846RwXUNpe0p5W/vtYPO2X
3OKrWDWKgA25/NoyDGgUk17wdhzH/o+pbSU75BeMy00+fZBkkArU8vE1vb9IMpMS
wSN8BfL0g8YnkyiaLu2QIHkjNJzMX9Ha7MUQMPsabhUiWj8JM4w2QUm6lBJ+q79m
ZsDfBno/vBSkMEjPa3TQmxZhEW/VRKHtfqt8+G1T6rlc+NdS8m4=
=XdQB
-----END PGP SIGNATURE-----

--Fj1Rlg69NjuwnVP3qc5bqPtjWQgNkiEE1--
