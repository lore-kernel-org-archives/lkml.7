Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B46AC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A0520748
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKXVer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:34:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:61977 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKXVeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:34:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="gz'50?scan'50,208,50";a="408123077"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2019 13:34:44 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iYzWl-000F9W-Vw; Mon, 25 Nov 2019 05:34:43 +0800
Date:   Mon, 25 Nov 2019 05:34:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] debugfs: remove modular code
Message-ID: <201911250505.gmOF60qe%lkp@intel.com>
References: <20191123163633.27227-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vqlzotvdnvtrqqvk"
Content-Disposition: inline
In-Reply-To: <20191123163633.27227-2-yamada.masahiro@socionext.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vqlzotvdnvtrqqvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v5.4-rc8 next-20191122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/drivers-component-remove-modular-code/20191125-040836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 0e4a459f56c32d3e52ae69a4b447db2f48a65f44
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs//debugfs/file.c:12:0:
   fs//debugfs/file.c: In function 'open_proxy_open':
>> include/linux/fs.h:2286:14: error: implicit declaration of function 'try_module_get'; did you mean '__node_set'? [-Werror=implicit-function-declaration]
     (((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
                 ^
>> fs//debugfs/file.c:174:14: note: in expansion of macro 'fops_get'
     real_fops = fops_get(real_fops);
                 ^~~~~~~~
>> include/linux/fs.h:2288:17: error: implicit declaration of function 'module_put'; did you mean 'mangle_path'? [-Werror=implicit-function-declaration]
     do { if (fops) module_put((fops)->owner); } while(0)
                    ^
>> include/linux/fs.h:2297:3: note: in expansion of macro 'fops_put'
      fops_put(__file->f_op); \
      ^~~~~~~~
>> fs//debugfs/file.c:182:2: note: in expansion of macro 'replace_fops'
     replace_fops(filp, real_fops);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from fs/debugfs/file.c:12:0:
   fs/debugfs/file.c: In function 'open_proxy_open':
>> include/linux/fs.h:2286:14: error: implicit declaration of function 'try_module_get'; did you mean '__node_set'? [-Werror=implicit-function-declaration]
     (((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
                 ^
   fs/debugfs/file.c:174:14: note: in expansion of macro 'fops_get'
     real_fops = fops_get(real_fops);
                 ^~~~~~~~
>> include/linux/fs.h:2288:17: error: implicit declaration of function 'module_put'; did you mean 'mangle_path'? [-Werror=implicit-function-declaration]
     do { if (fops) module_put((fops)->owner); } while(0)
                    ^
>> include/linux/fs.h:2297:3: note: in expansion of macro 'fops_put'
      fops_put(__file->f_op); \
      ^~~~~~~~
   fs/debugfs/file.c:182:2: note: in expansion of macro 'replace_fops'
     replace_fops(filp, real_fops);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +2286 include/linux/fs.h

7f78e035139405 Eric W. Biederman   2013-03-02  2239  
f175f307dd0bd1 Al Viro             2017-10-15  2240  #ifdef CONFIG_BLOCK
152a0836667108 Al Viro             2010-07-25  2241  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
152a0836667108 Al Viro             2010-07-25  2242  	int flags, const char *dev_name, void *data,
152a0836667108 Al Viro             2010-07-25  2243  	int (*fill_super)(struct super_block *, void *, int));
f175f307dd0bd1 Al Viro             2017-10-15  2244  #else
f175f307dd0bd1 Al Viro             2017-10-15  2245  static inline struct dentry *mount_bdev(struct file_system_type *fs_type,
f175f307dd0bd1 Al Viro             2017-10-15  2246  	int flags, const char *dev_name, void *data,
f175f307dd0bd1 Al Viro             2017-10-15  2247  	int (*fill_super)(struct super_block *, void *, int))
f175f307dd0bd1 Al Viro             2017-10-15  2248  {
f175f307dd0bd1 Al Viro             2017-10-15  2249  	return ERR_PTR(-ENODEV);
f175f307dd0bd1 Al Viro             2017-10-15  2250  }
f175f307dd0bd1 Al Viro             2017-10-15  2251  #endif
fc14f2fef682df Al Viro             2010-07-25  2252  extern struct dentry *mount_single(struct file_system_type *fs_type,
fc14f2fef682df Al Viro             2010-07-25  2253  	int flags, void *data,
fc14f2fef682df Al Viro             2010-07-25  2254  	int (*fill_super)(struct super_block *, void *, int));
3c26ff6e499ee7 Al Viro             2010-07-25  2255  extern struct dentry *mount_nodev(struct file_system_type *fs_type,
3c26ff6e499ee7 Al Viro             2010-07-25  2256  	int flags, void *data,
3c26ff6e499ee7 Al Viro             2010-07-25  2257  	int (*fill_super)(struct super_block *, void *, int));
ea441d1104cf1e Al Viro             2011-11-16  2258  extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2259  void generic_shutdown_super(struct super_block *sb);
f175f307dd0bd1 Al Viro             2017-10-15  2260  #ifdef CONFIG_BLOCK
^1da177e4c3f41 Linus Torvalds      2005-04-16  2261  void kill_block_super(struct super_block *sb);
f175f307dd0bd1 Al Viro             2017-10-15  2262  #else
f175f307dd0bd1 Al Viro             2017-10-15  2263  static inline void kill_block_super(struct super_block *sb)
f175f307dd0bd1 Al Viro             2017-10-15  2264  {
f175f307dd0bd1 Al Viro             2017-10-15  2265  	BUG();
f175f307dd0bd1 Al Viro             2017-10-15  2266  }
f175f307dd0bd1 Al Viro             2017-10-15  2267  #endif
^1da177e4c3f41 Linus Torvalds      2005-04-16  2268  void kill_anon_super(struct super_block *sb);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2269  void kill_litter_super(struct super_block *sb);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2270  void deactivate_super(struct super_block *sb);
74dbbdd7fdc117 Al Viro             2009-05-06  2271  void deactivate_locked_super(struct super_block *sb);
^1da177e4c3f41 Linus Torvalds      2005-04-16  2272  int set_anon_super(struct super_block *s, void *data);
cb50b348c71ffa Al Viro             2018-12-23  2273  int set_anon_super_fc(struct super_block *s, struct fs_context *fc);
0ee5dc676a5f8f Al Viro             2011-07-07  2274  int get_anon_bdev(dev_t *);
0ee5dc676a5f8f Al Viro             2011-07-07  2275  void free_anon_bdev(dev_t);
cb50b348c71ffa Al Viro             2018-12-23  2276  struct super_block *sget_fc(struct fs_context *fc,
cb50b348c71ffa Al Viro             2018-12-23  2277  			    int (*test)(struct super_block *, struct fs_context *),
cb50b348c71ffa Al Viro             2018-12-23  2278  			    int (*set)(struct super_block *, struct fs_context *));
^1da177e4c3f41 Linus Torvalds      2005-04-16  2279  struct super_block *sget(struct file_system_type *type,
^1da177e4c3f41 Linus Torvalds      2005-04-16  2280  			int (*test)(struct super_block *,void *),
^1da177e4c3f41 Linus Torvalds      2005-04-16  2281  			int (*set)(struct super_block *,void *),
9249e17fe094d8 David Howells       2012-06-25  2282  			int flags, void *data);
bba0bd31b117cb Andreas Gruenbacher 2016-09-29  2283  
^1da177e4c3f41 Linus Torvalds      2005-04-16  2284  /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
^1da177e4c3f41 Linus Torvalds      2005-04-16  2285  #define fops_get(fops) \
^1da177e4c3f41 Linus Torvalds      2005-04-16 @2286  	(((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
^1da177e4c3f41 Linus Torvalds      2005-04-16  2287  #define fops_put(fops) \
^1da177e4c3f41 Linus Torvalds      2005-04-16 @2288  	do { if (fops) module_put((fops)->owner); } while(0)
e84f9e57b90ca8 Al Viro             2013-09-22  2289  /*
e84f9e57b90ca8 Al Viro             2013-09-22  2290   * This one is to be used *ONLY* from ->open() instances.
e84f9e57b90ca8 Al Viro             2013-09-22  2291   * fops must be non-NULL, pinned down *and* module dependencies
e84f9e57b90ca8 Al Viro             2013-09-22  2292   * should be sufficient to pin the caller down as well.
e84f9e57b90ca8 Al Viro             2013-09-22  2293   */
e84f9e57b90ca8 Al Viro             2013-09-22  2294  #define replace_fops(f, fops) \
e84f9e57b90ca8 Al Viro             2013-09-22  2295  	do {	\
e84f9e57b90ca8 Al Viro             2013-09-22  2296  		struct file *__file = (f); \
e84f9e57b90ca8 Al Viro             2013-09-22 @2297  		fops_put(__file->f_op); \
e84f9e57b90ca8 Al Viro             2013-09-22  2298  		BUG_ON(!(__file->f_op = (fops))); \
e84f9e57b90ca8 Al Viro             2013-09-22  2299  	} while(0)
^1da177e4c3f41 Linus Torvalds      2005-04-16  2300  

:::::: The code at line 2286 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--vqlzotvdnvtrqqvk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLzu2l0AAy5jb25maWcAnDzbctu4ku/zFaxM1VZSZzIjy5fYZ8sPIAhSOCIJBgAlOS8s
RWYS1diSV5Ln8vfbAG8gBdCzWzUTm+gG0Gj0HYB//ulnD72e9s/r03azfnr62/te7srD+lQ+
et+2T+V/ewHzUiY9ElD5KyDH293rX7+9rA/b48a7/vXq18nHw+bam5eHXfnk4f3u2/b7K/Tf
7nc//fwT/PczND6/wFCHf3s/Xl7WH5/UCB+/bzbe+wjjD94nNQggYpaGNCowLqgoAHL/d9ME
H8WCcEFZev9pcjWZtLgxSqMWNDGGmCFRIJEUEZOsG6gGLBFPiwQ9+KTIU5pSSVFMv5CgQ6T8
c7FkfN61+DmNA0kTUpCVRH5MCsG4BLheYqSZ9uQdy9PrS7cWn7M5SQuWFiLJjNFhyoKkiwLx
qIhpQuX95VQxqqaSJRmFCSQR0tsevd3+pAbuEGYEBYSfwWtozDCKG568e9d1MwEFyiWzdNbL
LASKperazIcWpJgTnpK4iL5QYyUmxAfI1A6KvyTIDll9cfVgLsBVB+jT1C7UJMjKQIOsMfjq
y3hvNg6+svA3ICHKY1nMmJApSsj9u/e7/a780PJaLJHBX/EgFjTDZw3qJ5axueiMCboqks85
yYllYsyZEEVCEsYfCiQlwjOzdy5ITH3relAOqm8ZUe8K4nhWYSiKUBw3GgEa5B1fvx7/Pp7K
504jIpISTrFWsIwzn5hEmMCA+HkUij5F5e7R238bjD0cGoOcz8mCpFI0xMjtc3k42uiZfSky
6MUCik1KUqYgNIiJlSUabFdNGs0KTkShTAW3k39GjbGJnJAkkzBBatvEBrxgcZ5KxB96AlAB
zW6V+c3y3+T6+Lt3gnm9NdBwPK1PR2+92exfd6ft7nvHDknxvIAOBcKYwRQ0jcwpfBGoXcME
RAkw7NZJIjEXEklhhWaCWpnyD6jUq+E498T5PgKlDwXATGrhE4w1bK9NekWFbHYXTf+apP5U
rfGeV78Y5nze7gDrSRGdV5ZaWK20MrZhIWY0lPcXN90W01TOwQKHZIhzOZR0gWckqOS9kXSx
+VE+voKz9b6V69ProTzq5npFFqjhdiLO8sy+a8pUiQzBxlvBQAeeZwwoV7IvGberTUWv8jx6
KjvOgwgFaD9IM0aSBFYkTmL0YPNe8Ry6LrSD5UHf4XKUwMCC5RwTw7fxYODSoGHgyaCl78Cg
wfRbGs4G34aXgqiDZWAPIMQoQsaVwYEfCUpxz/oN0QT8YhPcxvL3vkHQMYHe4NlhpXrgPlwb
6jyFQCcC5x/HbGnENlnYfVQa030n4K4ouAduDBkRmYCWF53N7+1e12xuq6KihliWFc5QCua2
G6ryZ5UZNVq1ephhmaGIJA4heOLGID4SwMzcJDHMJVkNPouMGqNkrLckYBiKw8A0FkCT2aCd
jdkgZuBou09EDemgrMh5ZVcbcLCgQGbNG2OxMIiPOKcm7+cK5SER5y1FbyfaVs0CpTCSLnry
Brtu2w8zJOA6WAntSgjEkSDoa6gZGigxL1o/3DkAfDG5OnNSdf6QlYdv+8PzercpPfJHuQMH
gMB0YeUCwGd29t4xuI4aKiCQXywSJenY6nD+4YzNhIukmq7QfrEnkypeRxKCfUMuRYz8nvzH
uT26EjHzbVoO/WH/eUSakLE/GkBD8PcxFWByQXNYYh99lochpBIZgoE0LxBYZ2tkwUIaN+6+
ZlE/q2lREafCCElVuOAreUgDilJDehPDwUJAAJEFmP2lyA1j23iynho3jbMlgWhKngNAZKnP
wTsAb8ARDGbR9q+AaTJm2rEsqtK2GLYRlGxqmKwGWRSzHExb7Idt5Jgd9pvyeNwfvNPfL1Vc
0nOsLU8+TSYTe8CDPl1MJjF2AafufpfDfi3odjWZGEtDU/OLk5BIHd43OxGzNGpsSzvBzZVv
jeur/a1ERvmg4mrum3NpqFC2FjJh4HVfMpPMMiQE7HprDKXR/igEqwRGDkRHbY05DkTfF33G
dIDp9WSAeungYTWKfZh7GKYlRiUwmqR+Grki9m3TkAIUhlhNy5jQaKnxX4/e/kXVSI7e+wzT
X7wMJ5iiXzxCBfwbCfyLB799MGUMGm27hWkR+0ZwQplAGcVmA2hiITROS+I/p6BSA/RRbbt3
fCk322/bjfd42P7RM8igQiqPMszCDAlBRRFjCId0baUT7QA3YNuKOqiu1BiyBxAhW1FpuO2i
rSWNYGWih7Wa9WHzY3sqN2pfPj6WLzAcmP+GK0ZBiiMxG8QVrLKX5P655/LaZlOKdJprj5v/
kydZAbac2CKiqupR9R7WQjiRdkDVqipO4SAO7NJ1DZgxNj+3rKC+Oust5IxD6jJQ18spWIyC
hWEhB+NyEkH8kQa1nYfcUKeIZljVzd+tehxqRi0mGRo3TWiVJOEkW+FZZBuq3nilqLIXvzra
6/KgXgMwUhIMzlLn4oPRExbUM2QE09DUNgDlMeyACj+UjVRrOKNfVCDtt8HC2mgHJMOCQ46X
Egjl8Bw0IjB2XRtxHZGexSPVbg1A4KtTVpAQaKYqmgnDoU2uOADCIJtKFl8a8bINZORloQ6P
dMhtlXiVq5qBlDiLBCPMFh+/ro/lo/d7FaK9HPbftk9VnaKzhoBWU2G1wWPDtPYkziOa6loc
xvfvvv/rX+/Og583zESb9EnIlCCVMFVSh95CxaBdbbqWD5NrVZPK+bDK+ZEtoq5x8lTBh9JW
d22B5sh1vdduf+ruguO2LOzYtwaTRmNgJXkcNH8MR+eeRULBvqdGYaGgiQ7B7KlICuoExuUh
8VlsRwGxTBq8uUp8nEwUgEsUo9k8HxblgTiVeArqm6moX1dY2k/IfLGgIO6fcyJkH6LqD76I
rI0QtvYysLZcIUnEqXywrqzB+gImwJ6JKQycBBC+q0ifQ97mRFv6tpCvmkKlTqEYEqgYyjIU
nylqtj6ctkoJPAlRziAc5pLqYgTktqrOYRVpETDRoRrpdEh7zZ2nH8xokp98VqFQW31mXa3L
cOWABOGRrkIF4N4Uwwxd6oDzB1/7ha6SVwP88LO9It2brxMpvSUiAyOjlBNMH0TCpshpuPK0
NXwMZu27BLEhrs4msO6tuUP+Kjevp/XXp1Kf8Xk6AT4ZfPJpGiZSOalecaUfA6mvIlDeujnU
UE6trnga4l+NJTCnWS9VqAEJtca1anQ1uLn/Lrr1opLyeX/420vWu/X38tkaydXphlH8gQbw
hwFRpZYi6Z28ZDHYg0xq3oHbFPdXPf+K+zKb0AgS0l7TgoJPkAxy255OzUViWW7DwgSIgMGU
4gT8/mpy1xaGq3ijSVTrg5wQ0TjnvXizD7FMlRIQZAjWdTAwT3olyJiAtiIQdasBCTkDj71E
9sotdhymfckYszuVL35uN2hfxHnhplkeWtVBps5NE//+dmLoadAUO1SQOwcPY8+tCVeLd59S
RHlW+CTFswTxuVXj3eLW8dnwDPABWhkp52jI2NxXOTRJtYdutDMtT3/uD79DoHIuwSB3c9LT
oqqlCCiKLNzKU2rEbuoLFLG35bpt2LvzqrHNj65CbiiR+gLHGbEuGdJNumb83I2lG5Wr4yH4
e+t0GkXkPvjgmGK7O9Q4lbqNDQJbS4Wk2EV/QTOdFD6bOzQnDybFdZNtttbQmptMs6pajpHo
7RG0N36w4AyiRFsFDpCyNBt0g5YimGFrTaWC+oxJWy+OuF1NtSRmdAwYKcNOknxltR4Ko5B5
mpJ4MG+iF+c41knBbrI5dWTC1bALSZ3QkOVjsI4o+wRqpwo0c8MgDHUDK2FxCICNGalFJzut
whkwI43GoqMWB+e+mV82jqKB37/bvH7dbt71R0+C60Go3u7S4qa/a4ubWiZ14dDOAoVUnU0p
lSoCZDfbatU3Y0y+GXK5B2s1sj9xQrMbN1k0Rs4BtZ7Xm/PcB7Wt/dEGAmiCBJVnjIO24obb
tk+D00CVSlV8IR8yYtqJhZMCbUAyVYFRdS6HLGtEt7JVtJHopoiX1TRvoIGbsxc6gVfqGpSq
mAw9oaF+mczUVSxIm8LejYSmdzZ70HUIMMpJNvDJHeqwGtM2tWrSeEi8P5TKTUIQeCoPZ5fO
zvp3jtckrQbCbxAsz933Gc5Rz+7YjODGzG4DzjGZsGtfqg4101QHNC4EdVMAxoE00YUxIk4d
KSsbVnNBY4zpPTcgiJ2RAFqc13to9u+RvTSXIJgOdUBsr5yrzDhbPYyiBBDajcEVK52+swKP
defkPwSPEAlMACxIhcbUW6EADSO7Mca1mq1/3PzfGWs3tD3GOlFqxjrhHWecKDVzXeb+xs26
li1jqzZyz6ySeBf/A4wd0QCIN5Z2GA8cpSlwbFYAZKP2IunUMYPPaRDZ4tCqJK5iDoEGZk41
WQdbxCgtbifTi89WcEBw6lDkOMb2e5VIothuo1bTa/tQKLOfi2cz5pr+JmbLDKX2/SGEqDVd
OxSUyOoWkn3J2E6LDxuFdC3LCmYZSRdiSSW2Rz6LSr+cxldbf2ewmGSOiFatJRX2KWfCLtp6
/ZpSp6sAjPgS0myhHMIYVoqFLVhSIL5SVY+Hon+Txv8cD3Jc71Qe+xcQdTgxlxFJdWRUq/UZ
+gBg5soGE1DCUUDtt3SxQ4B8u8whsF8r7tLjsJhjW1VnSTmJB5EHDiMloBdnjrAF7Mry8eid
9t7XEtapyl2PqtTlQZCmEYx6Zt2i0l19YlSVR9SRklEUWVJotVuscE4dBX+1EXeOQg+i9kgF
k2xWuK4Rp6HjCoSAoNB1z1Z5pdAOs4W2jR4LWegqlnHAyRmQN7gBoWpkbNH3AnorgvKP7ab0
guEhd3WvCRunmtVHtxhMiSrQgfTbF4tpkVjVRkE+55TPB5elaFWYd44mpONikQJSZldfBcu4
PdfWMCSo3UTOmFSnZgrrjGuqbbPfnQ77J3XFtLsiUIn3+rFUl6wAqzTQ1D3ol5f94WTeU30T
t96l4/b7brk+aMQqQBXng42itUcLdtrbdZHd48t+uzv1TjmAUyQN9L1XazTS69gOdfxze9r8
sHOqv7XL2lbL4TUUY3z3aOZgGHHHTVqU0YGJ7C5JbDe1CnisLUR2hcPqFHdG4sxazwLXIZPM
PF5uWopEnfz2bg1JlAYoHlx67+jn1Vwh5ckScVK9UjmjOdwenv9U2/y0B/k5GHX/pT5WNZNL
fXWpHbD3TKbF1hVMywItmPaDz3qbhnS1FX19EqqO9nqHHS231HlcwOnCMXuNQBbckUdUCOqV
UD0MhOAJ2Dt7kKrQkHhIcYOsr5JYNra9hZflanaK69Ns89z8XHLae0+P2rb2rqWbzYY3gaRX
38Cw0hulrmNmaZd0FlrWog9VEnXLsLHt6uSxvjjYyV/VZOlfn83aDnXTPI7Vh6UXDjhLbH2U
+xAigDXQ7HK6stVfG9RcHWQ9D1tjxowzLLNVHyrpKxf3t0M45g+ZZLrv8zlRAffdx856pW/A
xep2FM6RPQ3SbFLRIA4W9hkg3yiUAy+ItMfB7RRvkMhFn9lVkLpISM+hDNet4NawBQDFMNxp
IlZz0OrgUr2kNLWiUd88SR7Usa0jP0KpdNz6lTRMtE2xQkmKYyZyMKNg3rT62j09ZPOxPXYW
rh0zPaL7+eJKXTSGMDUIHdcr8XSobtWxNQGTlPTihWZJGlLcXeLVjZXrg67GVP6ni8kZr6pH
Y+Vf66NHd8fT4fVZXww//gAr/uidDuvdUY3jPW13pfcI+7d9Ub+aNu3/0Vt3R6pusfbCLELe
t8ZxPO7/3Cnn4T3v1RUD7/2h/J/X7aGECab4QxNh0d2pfPISir3/8g7lk37D2zFrgKJsbmWi
G5jAENafNy9Y1m/t8lqwKoNAdzDJbH88DYbrgHh9eLSR4MTfv7T3asUJVmcevr7HTCQfjIi9
pd2guykSjfDJkCk8s0u/urAAvhurlzzYHkNrFC7F6h9g5MIev8+Qj1JUIPtzuZ7R6KUnNDBP
GvRHFXo+letjCaNAXrPfaJnUVbHfto+l+v/XA+yVSjN/lE8vv2133/befufBAFVAaWRB0Fas
QrC6CRvMpQxyRm2eTQEFQC0eTYGioD9OFKiheuctbWtmS5+MeXBw7gF1s3oo7jN1L5Nzxs8u
OtV4MIHjVCUg+m0jZFVY2tJOhaCeABbd8wHFvs2P7QtgNSL229fX79+2f/VtfRsAxEiqt2Hj
KwwSVIgwbHcWZMyYyMyozvv2stfqWwkp6HHBeNC/9dR0qyO+UQ+qjgdvphdvEz7ImBsoIvhm
EPGc48T04np1OY6TBJ+u3hgHJ8HN1TiK5DSMyTjOLJOXN/ZadYPyH7AynDkqTc2eUzo+D5W3
F5/sBVcDZXoxzhiNMhZRpuL209XFtTUuDfB0ArtTsHg8jmoRU7IcjwkXy7k97mgxKE1QZFfF
FifGdxPyxh5Inkzv7O9DGpQFRbdTvHpDbCS+vcGTydsy3iimuiRaG+lzndQ3SMGC9u5PI6pM
nLS+GFYdjLtDqntgvkrVLQP7oymop64eo7yHgOP3X7zT+qX8xcPBRwiLPpwbCmHYUDzjVZvl
oquw2gvBwdSmgfWhWTta72F52+oooeu1we+qUOAopGuUmEWR69KXRhBYFfJVmnsWtmheySY6
Ow52SmS02ple3UJBQjy6ZQXV/1Z9n4fkqD9TMux8jhJTH36M4PDMNkzz6nuwsJ/6HFvqF3E9
X6sh0nUEpqHq3lH13Hdkw1aRf1nhjyNdvYXkp6vpCI5PpiPAWiovlwVo+EormXumWeY4LtNQ
GOPOZSYahNGdQs5KXAVGeJw8RPGnUQIUwt0bCHcuB1nZpMXoCpJFnozsVJDJgk4deaOeX13m
AMEZweA4cZxfaTgB+qZ2eEIipI0o+B+IWsZxYvjFccmwxRlnBQQAbyFMxxU3QVxmn0f4mYdi
hkflVVLm+FMKmoQH7nh4rOdPHWFd7V5Wlxd3FyOzhwFLEE2daY5GigJHdaYyj44/OVEB1R9n
GhEmgKMLx+PPaoGS2GKeCvaQXF/iWzAJ04EX7SAqYlVXsUn1XEVnPBMXbnM1D0XC+IseAyx1
Qqcxbq5cGIl+R9lfyGdwbRQXF9PbkdV+jtFbljTAl3fXf40on6Li7pP9+FxjpCK7tEejGrwM
Pl3cOXmua9JnbjBL3jB7WXI7CLwGqxoImOn5BgFY19OejiaW9NFsS6q/YAKJIsGy16zeXCDe
a1Krmpy1XPTu69dt9m2toVfX9hgXwNWFQeRQMUDQQul4WnR213+w8CDRZy2SpudMCRJzHwHz
7KCyA/l5SJkNvXpbBUqRQqzP9fNAV/wWqPdd6vlhZr0wC2Bdx+6K4tAiUpSJGZODqeVM2SzO
FlTdvB+Z0P0WAoD6ec0oBuH2WEKNPDzt6kAJVfWJAcnqapQ6j9KP5VyDDpWog3whnPU404rN
YJ62HYyJa5oOx1Hh1bs7+BM9PWDu7lidK7qgYYzmxDnugjhf0SlhcF/RqRmsd9RxmJa88UxP
Ih4ReVZKrqFhLnqPg6pvlVWY/G9akS2ZqIH6hsf/MnYtzY3jSPq+v8Ixh43uQ89YsiTLuzEH
iIQklPgyAUpUXRRul6vKMXa5wo+IrX+/mQApAWQmVQd3l/AlQAAEgcxEPlby33ASdBAMC9Rv
jBCJnGpKSnkxurqZXPyxfHx92MHfn5RufalKiXYs5KBb8JDlek9uwYOP8ax+TjeJ7c6lVOic
0Ynsk2cxhis5rWm8LvHHL28rG9aRt4RiLFKsSb9krjhSEaHhHC0ZFSy0rTkElWvMneyKMQOE
Pmjm6gT6jmJynlCL0FSZP0Hw87C1M2tjAzI2OFvubi1LUkazBQx8x3bPLSi0Gzpdf3TsQ+LH
t/fXx78/UBuvnVGD8FyvAyOJ1rLjN6scL/3NGh3GO25ZTlVxuIrCO9ltXhpGAWj2xToPx95v
T8SigOPBb7IpQnOHcqkY57xTA3AgBp590oyuSA2eXykBCRKPpSCSiU5UlGtqUwmqGulvUXDO
gHTgLxhXcshTG1dgBZsLzWhiS6U4GH1uhKn47D8xgALFGPycj0Yj9p63wAUXcqVEm7AhZEYJ
+oFlRJfjmskDrY8wCWf+mtA8KgL014UIY1SYnHvVFXAJwR2JKzlki/mcDHrjVV6UuYg7K34x
obn+RZTiJkWfyaiZIYGoI1q23w6um6vAzgBaYNQRexDf0u5dsF+RsskIRxmJOIx6llFMv1cH
K2R+4JQA26oqpaG1THQotzVFB0MviiNM6+2PMP1STvCWMmzxewYSYdAvSb8ZvwpMucqCtRV3
FkC/Uiw7X5CpEj+wYizHo8tJ7Z3YruAQay8+RlvJO6USdC3cUbd+DdaRl11p1rkoPI1ETmra
GH2nMmQrDvMJLYzF6c3okl7t8MjpeHbmi8WAA5tgUpMxbS6vqyxGl6fh9iQw4jIIwLKQ47Pv
SX6O1v578aBVnq8Seumvg5eyLujoXH6FSuykIttS8/G0rmkIeGzPZFzCY04LBn9dBiweFjC3
tSta7QXlW8bLseaqAMA8ZMI+nd7UP6VnXmkqyq0MQ2em25QzYtcb5oJMb/ZnDsMUniKyPFg9
aVJPDpzWNKmnvE0RoHo3CC93Z/qjojK8hdjo+Xw6grq0HLrRn+fzSc/Cgm45b5b8sTaM/Xpy
deZ7tTW1TOlVnO7L4CYbf48umReylCLJzjwuE6Z52InHdkU0/63nV/Pxma8Q/olh2bKAGxwz
y2lbk85FYXNlnuUpvUdkYd/VAdprVDsp2u92mYh+C/OrmyC2XybHm/NvONuqWAWnlQ2IFHe4
xX7FfBP0GOjJmBNejSbcgsxApg6jOK2Bm4VVRk7sXqKp71KdERkKmWmMCUZOrlMA+0+8TcQV
dxd0m3T5L19ErGV24OBbUrvmd6RC46c0YB1voQCOI8aLuEzPvvgyDoZWzi4nZ1Z2KVHMCI7T
+ejqhrm0RMjk9LIv56PZzbmHZXjrRL6YEr27ShLSIoWTPLjp1niYdOUYoqaUt3STeQLCI/wF
XK1mVBlQflji6zqz8rRKRLhHRDfjyyvK1CGoFd6GK33D3cUoPbo580J1qoM1IAsVsXc7QHsz
GjFiA4KTczujziPYF2VNawO0sZt/6KSQwgL/jVdXZeG+UBT7VAr6FMPlIRnzZ3Soz5i9X1Vn
OrHP8gLkp4Db3EWHOll1vtJ+XSPXlQk2RldyplZYQx2iAlgCdP3XTPwB01GJ9dvchrs6/DyU
a8V4iSAKvBO8VkPFhvea3anPWRhFx5UcdlNuwR0JuFCzyzimXxUwHqTFIjJ1jf/EicO1hRgw
ymNyXVmEtx+K22EdjTILwdxlWAL4LiLUq1LmhfCiMDrdc2OTrtQFlLR3Z4SDkojxCmVN68JF
GvNYo4XhCer5/PpmtuAJzPzyqmZhmCo0kRjC59dDeKMaYQkiFYmY738jPLN4LOCdDzQfF8jX
jQdxE81Ho+EWJvNhfHbN4ktVS/4FqqhIKs3DKMEd6p3YsyQJGnGY0eVoFPE0tWGxRkg6iwM3
ztNYeWMQtkLDb1AY/k0cJQiWIrNR4wTfk9vB6g0XNIBbxoXHgXkZHCYepjxoQAKvaY4LVcCw
ZaqIf/gWb9u0ZPHGUWQFu9G4xP9S+1bhxfCCH5ijJgzshYWxxFB/0t9WsXggCATCacGYglsQ
L0FRoUN3KpdhD6zNYVhkne2MCS6tdKKoAEk6WXuVK71wkR2so15wxiMUCUOfEghuxI5ToiNc
yJXQjPMy4qVJ5qMpfQSecEZHBjjK3XNGZkEc/jhNM8KqWNP8167Dv7ae94ddTF17IPnpoiZ1
cgSFmeAeBa+8eXdsQKectBo2mvo6Lh/y1PIE2mpyCaijN+tCJTD4AVOaa8OEcSxKpdMwfAbR
6ElPRYESxHF2TkvRqEEp7CjUUaBv/+wDvmWyX24Y+s/72JflfMgyJzLLjjbc0gZguNg9YgyF
P/rxJv7EQA3oVPP+vaUiuKUddy2c1nhxxcnpwB5qRUsH9v6aiF9wOod1THLX20Bwh5+HouOl
2vhd/fx4Z43XVVZUYTg0LDgslxh+NOEiQDsiDArCxRVxFNoGMd6kzAp1RKkwpaq7RLbv1dvD
6xNmXXjEHC5f7zqOlU39HGNFD/bjU74fJpDbc3hnr/Cmlosx4Wpu5H6RizK4BG3LYAPZMP6s
R5Jkc5YkkzvDXOAfaTC0DWp16fd5JNMm34kdY+9zoqqys52qu0Prv7NA54oFh0LTB45DtSwV
I307AhDQE2nyirENckQgNUw5s0hHsdUgdQja4KvpyT4TheWIOKe/47rDOIv01ZAjsTGwmDBr
jgDHo4HHZfT5zYR2gi97Kjs1od1i13evX6xTqvpXftH1lLApQJ6Dn/hf61DvczkWgJOy8+YC
GMRRgPvVSkG7Fjm0sT3glkTzZD1G9m2omTJi26gsCQmtRCr799WNuQo1cyefVGK7dZvW97vX
u3sMZnbyEW9ZbOPlPtp6h2DkTIAwCHKmEythaJ+yJTiVrXf9MqA7FWO47jhIW4aRg29AyDR7
r21nU88WNhEIxtNZOOEg/2TOuyfm/COy/HPO3YQcVprxhHe5oDpc+qkixmgwpLoosbE70dI3
zLgAG74LIX6SpuV2k4Y6POdP9PD6ePdEZMpx45WiTPaRb/7SAHOX36hf6GVFtO6W7qV259FS
LpHpoyQTn6j3wn0w8BP1AVmLkkay8lCJ0mgvU6UPl5hPNJUNzYRuG3iv2E/E7KOpyDCkWGk0
jeu1KGUT556cFWezzYZUCDrLeQH5zfH70LEZM57PicgSLz/+QhxK7Bqx9nCE7WXTFM5Yophg
rzZdEmvy17QQ2k56hd4i6D71E/NNNbCOoowR/RuKZiv+ZMQKR/AbpGfJSuaaw8Elk+65gZc6
OSTFuWdYKpWh92+ftPUrCD/tXhs23QcjRcN202SxpM/lIlUHlwuT5uthSx5I+Ie8DGoXiaUA
52ajMfCMbEXtykHQCHdlE8FfQacq2HYD5NQqSfa9AbfBvHoHmMdm2JHANl1pY10KXTylPss8
jqjvA4upR/rkHvUVs3oYQyFdMOfNmo7gVuhQv6QHdAWZKZCiN1Asu396dAFD+gPGRqPEZm7a
2DSkjHrqSGWPsXNEq4KIAIY9+WZzIL2/BFHaHGoK6OfL/X/6siFGgx5N5/MmMfFzIEe7awab
Eo+NDu0J1HdfvtiEL/Cx2ae9/dO3/+13whueyiJT0mw/jpcLU7ijjfWKfIeBqLf0N+1QEJMY
ltzhmLwjoWWk9Y6zpUbz05QRX3YCA3nmlM+NRl3eKZHRaU1rKtsoCDeCJF90knq4y6GPp/fH
rx8/7m0qHv6KKF3GsMHEnBMMwnGS0Vv22kQ2CmFE60aSIjooRl5DjPMjx2d+EtnnQ5TmnFEV
0mxkWjChDuyozOzq5pqFt6rASCMcJ4skZRxdjZn7a8R1OmX83cSinl72QxaFtfc6YtYTwgbd
/K6upvXB6EjEzJUiEt6m9ZzxPMNx1vNpx5KyDU8ztES87V+uqqSbkfaERgOjRBVjmw6nt0JX
r3c/vz/ek1uoWFEK9u1KAHfh5TltCuwJucL0PyPvcIxL+vSF8kNcHCLZjy4goAoR+s4vdnRR
cfGH+Pjy+HIRvRwTif5JxO9uW/itCi5A4uvd88PF3x9fv8JhHHelyeWiTSLmuSktQO4yLqz/
sSgwtGpDMsL7oPQ22Cj8LYFBKAN/yQaI8mIP1UUPsME/FkmYdAFbghWBKcxdtmHyLQAV+uk2
kRvpHRtojErsAwzlHRVM1fdWcCc2OeyuKkuG2QO0SOkdDitimrExlzgYCGADTGCU9KFiJ0kb
yrAKIB3aY0DJsC4Pq4ziEWtQhivBmtlxKHCWLKauGYtqfFXClDn7zBLOD2Ynw/kx+9GYDi7o
UHao9LGCiNhyUWcQVezsZTKHJavozRTwzb6kzxvAruIlOwPbPI/znD4LEDbz2ZgdjSlVzHlT
4gx1k1v5y5ZtNIJNizPCwTlKdVTx46limpnBZbJID6vaTKb8F4FJ1SqGHcLF1NqnsgSLORtm
yr5fNha1Hdn1qPMxtyFeqZ3VhTy9u//P0+O37+8X/32RRHH/RuXEt0Sxy6LSWAWRvcAUsImN
V8qTtlFVh5/cZFL58fbyZKMQ/ny6+9VscH2e3sWijLoKo6AY/p9UaYYn5SVNgNnfvbAHy1Kk
ICAtlzaAbk8NQcCtBgfk51SUzNdNVCtzY5Wgv10hlvCrlMABiY3sXrG1rLRRQbePeVIGp/So
X8xXgXUh/ka9Q1XD4ZXRO4VHA+zJiGbMPKIoqcx4TF3lWqImlXtD5Y+hxz8dx5xXma+d6/yw
clwZFhVRGhZoedvavfmCCSAggKBLCzXXrqFj+0G1eJ+JVKFlW5bTYZjwqY5VxAhmYV5q2/Qx
apZX2EYLRDBMixqirCrH9o2JiWCbcEkWerNTof9Zb5R22vBzYloT0c01rMfAC8v2oG8kYou7
TQWowGDALAqbcKoYc0fEU1MI+lrUDcQpNUezKWNIYtsoqgkX8aMdbSNWiy2p+bRLpvOiRTya
z2+6cwF7g+JUmUfY8pSMRhSJqvmcieHRwuNh+GoA3jGKTcAWZn7N2EEDGonL0SW9UVg4VWzo
Hvwg6z0XRcnW1pPxnH9HAM+4QFMIm3rJPzoWZSIGZmylsiE4EfvB6q55JspN2zwPu+Z5HLZw
5v4AQYaJRgyjzl4x8esAxju4FeMLdoQ5Z7EjQfzpbAv8a2ub4ClkpkdX1/zcO5xfN8t0PvDl
r2MmUWML8t8oHDmj64G3Zo2o5jXf85aAf8QmL1ejcZdL9FdOnvBvP6lnk9mEkdDc0qnZ6wuA
s3TMBApyu2G9ZsKqAYrpmTGKLIunkgv75NAb/skWZawC3ZEw45eTDc45sI80+Jn92QoOueY/
jW09HvM93KdLKuXJOv7Lql6CSzu7DoVbLCRnfqz1X50qBdq/JcCL2BQ+XoAwwCu96J5baBEp
KtY5tKGoxGjgc3IGo0owV6INxawbrqJHsVZsVl97SkUxq+homyhyJgLYCV8PU5g8I8wvOkRb
YHuZfEh2LZIugJbfcJm83YtXcV9KgsLAyFLFmDoMWLw9CAulzFaM4S0QckYt1ZpUq2HTTVTm
tkf658M9XkpiBUJPhTXEBAODcF3ADJgVbwblKMqKnjmLFpzsfEQVc6eJeFVyTlJ2ImWyUTQr
4mCTF4cl7dmNBNEaBDrm8sXCCn4N4Hm1EnznUxHBh8tXBxkiVhvJRL20D7AabR6GyTHAyB/0
4nLKKNMs3Z7IQ+PhsNBWeQZyH/+iZKqHJlImMmIunx1M70YW+8zF7nLrOV0o5srE4ktG647g
Ok86Bi8BDM8dXtmbPT8hVWRdb1l8JxLDSEsIb5Xc6Zxzt7Uj25e8egIJ0OGI7x9nGYLYJ7Fg
rt8QNTuVrRktupu2DMNecmaiSJJEVgrjcZnlW35J4MwObkpWp2rNJwdIEsMFWXf4fpkILlMi
EJTSfRZ8C9aNJ1/SB4ulyNHKfmB1W3eR4TWYMdnPHVYqWixAFENV8Yu/EBneIif5wMdVyMxm
5RogMCLZZ/zuX8AGmjCRai2eQDdK/A743cnq9fhHlKjdHfgQyjyKBD8ELdTQNDXO2jxeSBl3
HX5CCjZqXIPKBJUfXMIdZU2k0bmOHyFnkYK7CNr6Cj1wiNhow5/y/eAj4JThP1fY57Rksqda
fI2WPE6vxe+nyO0cCuYOxu2oQ0dMrWCtsihGuhwcIHp/sEkZ7DTBrmcD2DCJWZBZSbpRi1vL
MIILcz4JekEzjY557jGOBcn3NcRtyrHmob22j4KGV+g3ka8jdcCrz0Q2F6meWS/gjbI0LMSY
D2EgEStdJIXq2rp5sE2wthb6sPbTsjhZxiPrJAWxNbMMNqQI0xrv2jxzPfkL0+A8PD3d/Xh4
+Xiz8/ByzFTotdVGZsbrYKVN91G8Ajkgy83qsFvDHpIoJnxpS7VI7DWNNt1F5I8PeG1dwaZi
tcSJ2P97HDbUsQg6rSJMqhSd8j3GfWbfvq7ZdX15eeCChyNJjctgiECeI8jrajy6XBeDREoX
o9GsHqRZwrRBS12a7prtrqJjKbWCThiRVSdcxOfGqRP0tx6iKOdiNpuCkDhEhJ2xiRbTzjF2
fLmNV1D0dPf2RolxduWQuYbtZ1RaZz/fDBGLdzE/dJP2bVWy3Mj/ubDjNnmJ1+FfHn7ClvKG
GaFsTO2/P94vTrlCLp7vfrWGgXdPbzZxMSYxfvjyvxdoyee3tH54+mnTTD1jHlZMMxV+qg1d
dwhN8YBFpU/VuBGepYuFEUtBb/M+3RKOVu5E8umURi0H83JaIvi3MKEzbwvpOC4vb3hsOqWx
T1XaC3Pt4yIRVUzzBT4ZZlxnOVSfcCPK9HxzjSyKcdaZxOo+tcxgahaz8YBzcSX6JwB+NOr5
7hu6ZPYcZOw2GkdzP4icLUN+Hv1Mw/lSBW9wZrfUOGOYFtuo/cJjxkTdnjM7xpyxAXm3adxC
r2eX5Og7wXTDye35vh2rhUcnU1+masb3CtAxrfS121RcGUZb5Lq21ZK6GrVu4nKVG5Qruyua
kzDs62nWW7S/jmb8REd7a1PLz3XMi5v2qDKxOkgunLMdOaq6YnhnXAh0OxJ+IOi2FQHHA6I7
ZxtpO5rvRFmqAQo2Bac73LV0WTox4IepBha+0mhysmRUlECwh9r8q5af7bwxgWLtZIBYhZdq
suz1+bhgi++/3h7vgbdO7n7RSbOzvHB8TSRV5/7Z45SZdsIOrUS8Yoy5zb5ggm9bPgDNRwYi
zacpY24rU97nE1lgWFE0ayqiCLOTLFTChaZX8N9MLURG8ValidDV8sRWYYE1LgqL1hHwq3u6
sLXn+Mfr+/3lP3wCDOELfFhYqyns1Dp2F0k4uwnEssYDz776EmNd+G7eHiEwQ0uXoyp8vi1H
sw6iuJPN2S8/VEoeugYqYa/LLb1+0SEFe9qJeY6eJ0wxekgwtYqnu3fgoJ47WK8nsR6NGett
j2Q6oi+HfJIpvZt6JLP59LAEIYrRgXuU1xN6GziRjCeX9B1tS6LNZnRtBG342RKlk7k5M3ok
uaJDAfsk05thEp3OxmcGtbidzJnIwS1JWUwj5p6uJdleXY77PMDLj7+iouoshk7N011Rr9Gl
gX9djvrtovJAP/zAdLvMQovRu4MWzAFaVEtPGj9WslFvlqp7U9SG9A/rebtcVQ+eqFxIU1Ue
4+QQ2wnCGBhNZlUYaM4Wc6Yxba2UcJtKH+9fX95evr5frH/9fHj9a3vx7eMBBHbf4POYw3eY
9PTAVSn77nXtfBrBpjxc72ArydANq9fPyPpN6ZeP13sytwKJe8eVUMkipwLaqjxNK0+D5Bwy
0JHs8f7CghfF3beHd+sOpvuzco7UO9bsk+xJseyvwPLh+eX9AVNGk3ukTEEAwDOAXIZEZdfo
z+e3b2R7RarbhUG3GNT0Xh9aVHbzq7hTAPr2h/719v7wfJH/uIi+P/788+IN9YtfYXo6ma7F
89PLNyjWLxH1NinY1YMGMXsGU62POqPm15e7L/cvz1w9Eneqhbr41/L14eENGLCHi9uXV3XL
NXKO1NI+/jOtuQZ6mAVvP+6eoGts30ncf1/RwfQNQerHp8cf/9drs6nUBDLbRhW5NqjKR4Xy
b62C06MKTL20XZaSNuiQNeaH4TjQnLkhV8zumhlargcGjfV/Lnb9UAnokY/Zq6ldsod53cJo
zOyDrDsmWmgb4MkTwqkYw87pj7/f7OT6r6s5LYciSB42eSaQ4efjNKJfa1GLw3iepegyzLjh
+lTYHrlCwq56tVFGjpg4SWmodXFjBkYZWMe7H7CrP7/8eHx/eaUmfYjMm2FCHyN+fHl9efwS
eNxlcZl3s/u1O0xD7jEVggyT3vD8/s8ja+/YlR3mFrpHPRAVScHQAr+LVtm1y2mvT/pNnmou
ixVjyMdaTyYq5Rar1dvCvzMZ0VKnDZzSvVRrmab/r+zKmhu3kfD7/grXPO1WTRJf4/E8zAPF
Q6TFQ+YhyX5haWzFVmUsuyS5ktlfv90AQQFgN+StSuII/eEk0A00Gt2mKyn5gG0NTFPOF4MV
zbw0Cbw6bKOqFW62qKcNQAPh6mlBIoBvnLemFXyX1C4w8jBRCNAvhlkuRMVFlSzg4EqfpBSq
Cv3GDrd2gFwOy778UNmXXNkmiDuB3oyCc71e/M2CoaZMBlk0tt5hAuMONCZ48s2ApOSIIOg6
MUy5bYqanoqLo+OBCMZeDklFju9B28ovmctQBM29kpYoSOQV9rBpO+dGYFQ7hidPUkfW6JzP
ie0h2Uu4wN2qPaFkWheisphSXwQPMipqpe5WIw9QdXdn0/WWhLmIV8k+S6qIcIY9zX6VG9gJ
iUwQzqqMij1JIOsczKT+8FUXUXVpPJGRadYijNDNGTP4+IwKjm8tsVf3lw/Ppo++qCICa6qj
iURLuIhg/0cwCwTHOzA8NQxV8e3q6tRo+U2RJqb773uAMa1ugmjQIdUOum55/i2qPyKv/iOv
6XYBTa5kNWMqyGGkzGwI/lYX2fjOZ4rXZJcXXyl6UvgxMvf6+6f17vX6+su3384+6ZPgAG3q
iFak5DWxkJTEobsntxi71fvj68mfVLcHD61EwsR0TyTS0IVBnVqJ2GW8F09gbenfTxD9OEmD
MqScXk7CMjeed5k6wTqbmtNYJBzhnBIzEH6Hs3czDut0RPJx2LxEnU2nIRjkH37YiaHti8Sn
fMhtZNA0oztF6eXjkGeLXuCgRTwtdpKEl3COvztaM+JJjlx+6WUMqbptvCpmiLMFX2aW5DAB
OHaWOXo/5Wm3+eLSSb3iqaWr0inepDIW+HfVjMvWOIa7LLidiHLeY844RVRyQfs9O7d+Xxhu
aEUKu9YEmdYJI6mae5RPj7Io6ja3GhKYv4btCI40JLBaonYzwtPgFD1DalWg5Ld/Qn5zKHrD
KvW1mrycGrpameLYS/nhNGZXRsIRisDjlz334VN9PNNKyRFD0GhkJalakFT6xtWgfb2gnemY
oK9f6PYcINdfTtk6rpn3RxaIvg6wQB9o7fUVbcdggWiFvwX6SMOZC28LxKwhE/SRIbiib1Ys
EH1xYoC+XXygpG+MUYhV0gfG6dvlB9p0zfj5RRDsFHGWt8yeSS/mjLNlsVFkmCXAeJVvBMHW
qj+z57ki8GOgEPxEUYjjveeniELwX1Uh+EWkEPyn6ofheGfOKG5tAL7YYzkpkuuWCRuuyA1L
xiBRIKgZ+xCF8MO0TpgAbT0kr8OG8RrTg8rCqzlPSD3orkzS9Eh1Yy88CilDxqpOIRIfLWMY
D74KkzcJrXIwhu9Yp+qmnCQVGYwLEHisMYyH8sQfvB1Q3lt0XVnnu/fhfbve/6IuMNlnXEqn
1AZZWAn9c10mjDrPqX9SRFIAx94shP+UQZiHgTjeow+tVrwb9axz0QBGV4fOUXyBQbtU6TaL
qFmdGA/99DQLirTKvn/CS8PH1783n38tX5aff74uH9/Wm8+75Z8rKGf9+BktNZ5wYD/JcZ6s
tpvVT+Fga7XRoiqoa61s9fK6/XWy3qz36+XP9X+V97OuTtif19h8f4Luo42jlCAVuRyXvumM
rkWB0c6TxapbW7pJisz36OA81ppbqjdCHVQofba//fW2fz15QDPZ1+3J8+rn22p76LoEQ/fG
hjcTI/l8mB56wUGgaIlD6Cid+BhupRzge8owUwwHLTJxCC3zMdE+tuTJdErAMdLPMFmGHB02
vEs31LcdqaEV4WbGNkgq9LsvbHyqQbXoTXxQJyZSFYo/lD2W6lpTx6EeMahLx6qVT9Xp+4+f
64ff/lr9OnkQs+UJ/fb80pmVGmzGnXVHDmhbtY4a+sfoZVAN3YR67/vn1Wa/fljuV48n4UY0
Ed1B/r3eP594u93rw1qQguV+SbTZ95m4iJI8dpP92IN/zk+nRXp3dnFKb1j6BTBOKs6RXIep
wlvbptAehdgDPjIbjMNIWFK8vD7q5mmqlSNfF1IqNaKV7YrMaJx6Mqch6drpLDwtaSvPjly4
mzaFDrnoC3fbQLTOS+Y2U30rfK1UN9QLCNXBqkpmaonEy91zP/aDkeLCKSrGdYS+ONLbmZVf
aobXT6vdfjgTSv/i3CcZhc8cbFQrFrFHboMOBdRnp0ESETNtbGcdfNAPLJ8soLbYPfELUW+W
wGoJU/zrKrnMgiPLEhHMSfuA4JyiHBAXjKsgtfhjjz6oH+hH6gDEF8YrzAFBH2YUnXHIqMg1
7F1GBaMe6mTHuDz75mzEfGq1Uq6a9duzZdHSc07negZyyzxqVoi8GTE+NRWi9B3TayTiasOm
Y7hJkQSlXSO4rJeFcChyCkbfq2rn3EfAFd+8NMHHh9WgdTLNLiwSf50MMvbuPfp0peaBl1ac
4ytLNLrFHfPKt6eXU86xaD9haT1Cv5Fxjnw9LyLrdNd5rHx52652O+Mc0I/qIMqj+g739Cm6
I18z5rt9bmdPgBw72dh9Ze70pCnhcvP4+nKSv7/8WG2l1ePBt7O9SCoMp1wyVp6q9+VoLCxZ
XaCbBP3RhGgTxZwGtQ0xOkpsj0mIHlh1e/cPgY/0pcfh2cQpoufDGbLa7tE4DvaWO/HScLd+
2iz373COenhePWDwPsPQ9QNwgU/XP7ZLOPltX9/36425oUBDNMsIt6OMEmDMaH2sXXAq+zLg
2bkPZ/eoLDJ1UW9BMMxfUyepcZ/nF2WQUF6KesM1P7ENeHz0pu7D19d5kX92ZSKojYLfJnXT
Um6mxdbE3LJAAsb7juxXECYgTfxwdHdNZJUUbrkJiFfOPcbjiUSMGO0SUBkFuG/JGJ3wlegG
sPVuv2aOFPMiQQQ5cQ/MPUoKjDojb4T11ANXU7XfI6vDoy8+d9M0MPeXZPrivjW8gsrf7eL6
apAm7AmnQ2ziXV0OEr0yo9LquMlGAwLGdByWO/Jv9EnQpTJjdOhbO75PtLmtEUZAOCcp6X3m
kYTFPYMvmPTL4TLVtW8dCZ0ewBrUrRZlknBDa6xNTA/01uUgfdtKPLBABzrjOrZoSIAihOrO
UHshAfkm63d2nMrGan271cws8hQNGogO1gXs1a8uDRVbeSuCeRLVREVea28A+iyYTppRIf76
n+tDxV2KzqAqtHcttMYK5xJ5gQRx+NagwAPkEGtazhI4NLkGe1kwYPGmklLJDpH6tl1v9n+J
d1qPL6vdE6Uqls6BhddikjN0dPQdRqufOnfUaTFOQYik/WXrVxZx26BtU+85MIMpi7dMgxIu
D63AuEuqKcITBdlW5SSDuITuRo8dkX7jtv65+m2/fukk605AH2T6lho/UReyxYIYnDAXurgM
Q0f5cehrUYOFS29hl/gdzo+n5iTAWNxoO5xxZuNeIAr2Kjr6FTZJNyqIQ4xxAysb4xfqIZEV
wWochu7LkvsQMqRJbtkFyuKr0Ee7QDTqyTzrJanqiQURvUV7zTtrfcw9WEhyQKaFjAVtD1SX
PmxHVJQ+jGPoTdCyocVnZtSH//Cn7WclOvVCqxQRq2+Y2Ovg5Tf+fvrPGYWSr9t1Lo2NRmOv
cJCK9lFKtd6p8IPVj/enJ7Ud7Hdy6IsA4xBWnGWmLBCBgpPSK1v4U5jnXIQuJMOwo184Zics
aykL9FHBP+SWqGJ0E3Jqv25GpYybi44s7lCaigt9IVEzJuqNHGDxfERcpXC3VlpdaAwawRGd
mPs6mShp4lVeLlHfz/5lX8scvmnPIX0hXyGTX8y6gKCmdU1Xb2zFhZTaOizvJH19+Ov9TU7q
eLl5Mh80FlGNhj3NtAtPwDzI72IXxA1Iodqr6HvU+S0Z1Usz9afbo0+tHBYIcIaCtlg26Pgc
oIH1ZRJRXhVNfUiugIV1vuwNkYrJuAVh7kNFLjm10MuR4IOOGYTVTsJwSsXjwR4fPu7Jv3dv
640ICPf55OV9v/pnBf+z2j/8/vvv/xkKENxvNXW4YJRV3fcnXkqaE1wWMZw55bwKGWEiAXLz
BGsQOueAdWbi8jDdbVPoYoVBOswzdNrA84b5XLb5yJ7n/xhZXZDCVxWLia4ahRFwx7bJUZME
08ARs7Jj25KJORDwbxd1wTWInG+ujmsfoVcuZiws5xMupJTE+GWIEXdALhFPUv2GFjpAQAEb
8d8SEUc/uACx3wSp4S35IkO9UTXaZ/cMWJPcD5TETsD8UGJ+ghDFp4iMpUc3lG1YlkUJUuNG
7mdIcGfT7sTgETn37yxHrLr0iZpcbpnEEBknNZ06Lr1pTGPUFjiSUmSe1DGGsKssGJqu49wX
KLG30m3NRVYZGvPgfQKXvQxBQyaKI9tc2LmaJYkTje2sTzbPfJZhdJ05i4RhBltT2FfBQSFn
OA+QQd5FroIk23cA4jl8LBeg29mrTaBEMi96ugjfcsiZiLsif1vlnnCSRSnp0OFOjM8IxHsd
25ZEpaNLwlqE35YZGHnSw2EOOIFSNDoGQrlYSwrHuo7RzyC6hx1zg3SYiO0IFkmccXG/9Cn3
cSR0AxjTlOdL2tQS50tOwaMihCMZy7fdMqSTgHnGKbwYCYeLFef+XUBY6kiJMyEsHSx2hPds
DrrQ3BRpkeFq41DiuAVbr9ZdGIgEYLQ8XSllGAGvdzwOF0GT0bsPOTJSPeKKmahwlc9cHQjA
BBA18wJWAISmgfYvLuhSdeOkg+Rg3GcJRNPYr4116sIrS0bHIejU2cNElHgnUiOPcgw4d20i
qAnjjU/O44ljks8y/tApO1+JOGauTzSauoYffZfGMggabfASJRjQITnGTDrPYjI+qGNCiYde
jv7wKqluQgrrRdYqU07KjIktIb1xhpkPEsm5OsQFD3OxoAphAUBjl6c4v+fCFSVe7JQN/yS0
8jA6IWsUKtQ9k3FgxAnB30SG3i9vMxLHaTj31aiTkgqsPregEtllLi9Nxjkw6dre3gCnj1Jv
XBkqYNtAUmpT/wcLUwrwgfwAAA==

--vqlzotvdnvtrqqvk--
