Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452BAECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180E5206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJIIq6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:46:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55042 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:46:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iI7cP-0002a4-HA; Wed, 09 Oct 2019 02:46:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iI7cO-0003fB-9m; Wed, 09 Oct 2019 02:46:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Philipp Wendler <ml@philippwendler.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Reid Priedhorsky <reidpr@lanl.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        Yang Bo <rslovers@yandex.com>, Jakub Wilk <jwilk@jwilk.net>,
        Joseph Sible <josephcsible@gmail.com>,
        Al Viro <viro@ftp.linux.org.uk>, werner@almesberger.net,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        =?utf-8?Q?St=C3=A9p?= =?utf-8?Q?hane?= Graber 
        <stgraber@ubuntu.com>
References: <620c691a-065e-b894-4f06-7453012bc8d3@gmail.com>
        <d449305b-f87c-f26e-e43f-d193fd8f4332@philippwendler.de>
        <e51e454c-b0e7-e5d1-7810-e8f023574aa2@gmail.com>
Date:   Wed, 09 Oct 2019 03:46:02 -0500
In-Reply-To: <e51e454c-b0e7-e5d1-7810-e8f023574aa2@gmail.com> (Michael
        Kerrisk's message of "Wed, 9 Oct 2019 09:41:34 +0200")
Message-ID: <87y2xu71dh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iI7cO-0003fB-9m;;;mid=<87y2xu71dh.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/c/bS/iIQza/ug6UXm9TOVVep9XRjAqd8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: For review: rewritten pivot_root(2) manual page
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hello Philipp,
>
> My apologies that it has taken a while to reply. (I had been hoping
> and waiting that a few more people might weigh in on this thread.)
>
> On 9/23/19 3:42 PM, Philipp Wendler wrote:
>> Hello Michael,
>> 
>> Am 23.09.19 um 14:04 schrieb Michael Kerrisk (man-pages):
>> 
>>> I'm considering to rewrite these pieces to exactly
>>> describe what the system call does (which I already
>>> do in the third paragraph) and remove the "may or may not"
>>> pieces in the second paragraph. I'd welcome comments
>>> on making that change.
>> 
>> I think that it would make the man page significantly easier to
>> understand if if the vague wording and the meta discussion about it are
>> removed.
>
> It is my inclination to make this change, but I'd love to get more
> feedback on this point.
>
>>> DESCRIPTION
>> [...]>        pivot_root()  changes  the
>>>        root  directory  and the current working directory of each process
>>>        or thread in the same mount namespace to new_root if they point to
>>>        the  old  root  directory.   (See also NOTES.)  On the other hand,
>>>        pivot_root() does not change the caller's current  working  direc‐
>>>        tory  (unless it is on the old root directory), and thus it should
>>>        be followed by a chdir("/") call.
>> 
>> There is a contradiction here with the NOTES (cf. below).
>
> See below.
>
>>>        The following restrictions apply:
>>>
>>>        -  new_root and put_old must be directories.
>>>
>>>        -  new_root and put_old must not be on the same filesystem as  the
>>>           current root.  In particular, new_root can't be "/" (but can be
>>>           a bind mounted directory on the current root filesystem).
>> 
>> Wouldn't "must not be on the same mountpoint" or something similar be
>> more clear, at least for new_root? The note in parentheses indicates
>> that new_root can actually be on the same filesystem as the current
>> note. However, ...
>
> For 'put_old', it really is "filesystem".

If we are going to be pedantic "filesystem" is really the wrong concept
here.  The section about bind mount clarifies it, but I wonder if there
is a better term.

I think I would say: "new_root and put_old must not be on the same mount
as the current root."

I think using "mount" instead of "filesystem" keeps the concepts less
confusing.

As I am reading through this email and seeing text that is trying to be
precise and clear then hitting the term "filesystem" is a bit jarring.
pivot_root doesn't care a thing for file systems.  pivot_root only cares
about mounts.

And by a "mount" I mean the thing that you get when you create a bind
mount or you call mount normally.

Michael do you have man pages for the new mount api yet?

> For 'new_root', see below.
>
>>>        -  put_old must be at or underneath new_root; that  is,  adding  a
>>>           nonnegative  number  of /.. to the string pointed to by put_old
>>>           must yield the same directory as new_root.
>>>
>>>        -  new_root must be a mount point.  (If  it  is  not  otherwise  a
>>>           mount  point,  it  suffices  to  bind  mount new_root on top of
>>>           itself.)
>> 
>> ... this item actually makes the above item almost redundant regarding
>> new_root (except for the "/") case. So one could replace this item with
>> something like this:
>> 
>> - new_root must be a mount point different from "/". (If it is not
>>   otherwise a mount point, it suffices  to bind mount new_root on top
>>   of itself.)
>> 
>> The above item would then only mention put_old (and maybe use clarified
>> wording on whether actually a different file system is necessary for
>> put_old or whether a different mount point is enough).
>
> Thanks. That's a good suggestion. I simplified the earlier bullet
> point as you suggested, and changed the text here to say:
>
>        -  new_root must be a mount point, but can't be "/".  If it is not
>           otherwise  a mount point, it suffices to bind mount new_root on
>           top of itself.  (new_root can be a bind  mounted  directory  on
>           the current root filesystem.)

How about:
          - new_root must be the path to a mount, but can't be "/".  Any
          path that is not already a mount can be converted into one by
          bind mounting the path onto itself.
          
>>> NOTES
>> [...]
>>>        pivot_root() allows the caller to switch to a new root  filesystem
>>>        while  at  the  same time placing the old root mount at a location
>>>        under new_root from where it can subsequently be unmounted.   (The
>>>        fact  that  it  moves  all processes that have a root directory or
>>>        current working directory on the old root filesystem  to  the  new
>>>        root  filesystem  frees the old root filesystem of users, allowing
>>>        it to be unmounted more easily.)
>> 
>> Here is the contradiction:
>> The DESCRIPTION says that root and current working dir are only changed
>> "if they point to the old root directory". Here in the NOTES it says
>> that any root or working directories on the old root file system (i.e.,
>> even if somewhere below the root) are changed.
>> 
>> Which is correct?
>
> The first text is correct. I must have accidentally inserted
> "filesystem" into the paragraph just here during a global edit.
> Thanks for catching that.
>
>> If it indeed affects all processes with root and/or current working
>> directory below the old root, the text here does not clearly state what
>> the new root/current working directory of theses processes is.
>> E.g., if a process is at /foo and we pivot to /bar, will the process be
>> moved to /bar (i.e., at / after pivot_root), or will the kernel attempt
>> to move it to some location like /bar/foo? Because the latter might not
>> even exist, I suspect that everything is just moved to new_root, but
>> this could be stated explicitly by replacing "to the new root
>> filesystem" in the above paragraph with "to the new root directory"
>> (after checking whether this is true).
>
> The text here now reads:
>
>        pivot_root() allows the caller to switch to a new root  filesystem
>        while  at  the  same time placing the old root mount at a location
>        under new_root from where it can subsequently be unmounted.   (The
>        fact  that  it  moves  all processes that have a root directory or
>        current working directory on the old root  directory  to  the  new
>        root  frees the old root directory of users, allowing the old root
>        filesystem to be unmounted more easily.)


Please "mount" instead of "filesystem".

>>> EXAMPLE>        The program below demonstrates the use of  pivot_root()  inside  a
>>>        mount namespace that is created using clone(2).  After pivoting to
>>>        the root directory named in the program's first command-line argu‐
>>>        ment,  the  child  created  by  clone(2) then executes the program
>>>        named in the remaining command-line arguments.
>> 
>> Why not use the pivot_root(".", ".") in the example program?
>> It would make the example shorter, and also works if the process cannot
>> write to new_root (e..g., in a user namespace).
>
> I'm not sure. Some people have a bit of trouble to wrap their head
> around the pivot_root(".", ".") idea. (I possibly am one of them.)
> I'd be quite keen to hear other opinions on this. Unfortunately,
> few people have commented on this manual page rewrite.

I am happy as long as it is pivot_root(".", ".") is documented
somewhere.  There is real code that uses it so it is not going away.
Plus pivot_root(".", ".") is really what is desired in a lot of
situations where the caller of pivot_root is an intermediary and
does not control the new root filesystem.  At which point the only
path you can be guaranteed to exit on the new root filesystem is "/".

Eric
