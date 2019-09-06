Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6611DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4329820578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392264AbfIFQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:41:24 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:54488 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732541AbfIFQlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:41:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 89F78241179;
        Fri,  6 Sep 2019 18:41:19 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OXLey5hysWb; Fri,  6 Sep 2019 18:41:18 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-037-138-233-152.ewe-ip-backbone.de [37.138.233.152])
        by smtp1.goneo.de (Postfix) with ESMTPSA id A237F23FE7D;
        Fri,  6 Sep 2019 18:41:17 +0200 (CEST)
Subject: Re: [PATCH] docs: license-rules.txt: cover SPDX headers on Python
 scripts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
References: <20190905055614.7958918b@coco.lan>
 <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
 <20190905065701.4744e66a@lwn.net> <20190905141723.GB25790@kroah.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <14b7cc52-5814-36d6-2625-5aa7eea20082@darmarit.de>
Date:   Fri, 6 Sep 2019 18:41:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905141723.GB25790@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 05.09.19 um 16:17 schrieb Greg Kroah-Hartman:
> On Thu, Sep 05, 2019 at 06:57:01AM -0600, Jonathan Corbet wrote:
>> On Thu,  5 Sep 2019 06:23:13 -0300
>> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>>
>>> Python's PEP-263 [1] dictates that an script that needs to default to
>>> UTF-8 encoding has to follow this rule:
>>>
>>> 	'Python will default to ASCII as standard encoding if no other
>>> 	 encoding hints are given.
>>>
>>> 	 To define a source code encoding, a magic comment must be placed
>>> 	 into the source files either as first or second line in the file'
>>
>> So this is only Python 2, right?  Python 3 is UTF8 by default.  Given that
>> Python 2 is EOL in January, is this something we should be concerned
>> about?  Or should we instead be making sure that all the Python we have
>> in-tree works properly with Python 3 and be done with it?
> 
> I recommend just using python 3 everywhere and be done with it as there
> are already many distros that default to that already.

As far as I know: many distros have installed py3 and py2 interpreter
by default.  Mostly for internal purpose the distros use the py3 but
the 'python' command is default binded to a py2 interpreter.

About Linux distros and python2 & python3 read:

   https://www.python.org/dev/peps/pep-0394/

In short: command 'python' mostly refers to py2 interpreters as long as py2 is
supported, later the distros will remove the python2 stack.  So it depends on
the distro and your alternatives(8) setup.  The common rules for distros are:

   https://www.python.org/dev/peps/pep-0394/#for-python-runtime-distributors

and what debian says:

   https://debian-python.readthedocs.io/en/latest/debian-policy.html#versions

IMO we can't predict what the python command will call py2 or py3 interpreter.
And we scould not fergett that not all (build hosts) are using up to date

At least I have to say that it is always recommended to use a
virtualenv build up using requirements.txt and option

May we can and add option "-p python3" to:

 
https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html?highlight=virtualenv#sphinx-install

  $ virtualenv -p python3 sphinx_1.7.9
  $ . sphinx_1.7.9/bin/activate
  (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements.txt

BTW: I always recomend to use (support) up-to-date py-packages, but we had
this discussion already.

  -- Markus --
